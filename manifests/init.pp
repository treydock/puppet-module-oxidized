# @summary Manage Oxidized
#
# @example
#   include oxidized
#
# @param manage_repo
#   Sets if repos needed for oxidize are managed.
# @param ruby_dependencies
#   Ruby dependencies
# @param install_dependencies
#   Additional install dependencies
# @param with_web
#   Sets if the oxidized web should be installed and configured
# @param user
#   Oxidize user
# @param user_group
#   Oxidize user's group
# @param user_uid
#   Oxidize user's UID
# @param user_group_gid
#   Oxidize user's group GID
# @param user_home
#   Oxidize user's home directory path
# @param user_home_mode
#   The permissions of oxidized user's home directory
# @param config
#   Oxidize config hash
# @param config_mode
#   Oxidized config file permission mode
# @param source_type
#   Sets type of source to be used
# @param devices
#   Information about devices.
#   Only used when `source_type` is `csv`
# @param devices_map
#   Map of CSV fields for devices
#   Only used when `source_type` is `csv`
# @param devices_vars_map
#   Set `vars_map` for device CSV configuration
#   Only used when `source_type` is `csv`
# @param with_service
#   Sets if the oxidized service should be installed and running
# @param service_start
#   The command to use to start oxidized service
# @param show_diff
#   Boolean that sets show_diff property for files
# @param log
#   Path to oxidized log file
# @param log_mode
#   The permissions of oxidized log file
# @param models
#   Hash of models passed to oxidized::model
class oxidized (
  Boolean $manage_repo = true,
  Array $ruby_dependencies = [],
  Array $install_dependencies = [],
  Boolean $with_web = false,
  String $user = 'oxidized',
  String $user_group = 'oxidized',
  Optional[Integer] $user_uid = undef,
  Optional[Integer] $user_group_gid = undef,
  Stdlib::Absolutepath $user_home = '/home/oxidized',
  Stdlib::FileMode $user_home_mode = '0700',
  Hash $config = {},
  Stdlib::FileMode $config_mode = '0600',
  Enum['csv'] $source_type = 'csv',
  Array[Hash] $devices = [],
  Hash[String, Integer] $devices_map = {'name' => 0, 'model' => 1},
  Optional[Hash[String, Integer]] $devices_vars_map = undef,
  Boolean $with_service = false,
  String $service_start = '/usr/local/bin/oxidized',
  Boolean $show_diff = true,
  Optional[String] $log = undef,
  Stdlib::FileMode $log_mode = '0644',
  Hash $models = {},
) {

  if $facts.dig('os', 'family') == 'RedHat' {
    $bootstrap_command = 'scl enable rh-ruby23 -- oxidized'
  } else {
    $bootstrap_command = 'oxidized'
  }

  if $source_type == 'csv' {
    $router_db = "${user_home}/.config/oxidized/router.db"
    $default_source_config = {
      'default' => 'csv',
      'csv' => delete_undef_values({
        'file'  => $router_db,
        'delimiter' => ':',
        'map' => $devices_map,
        'vars_map' => $devices_vars_map,
      })
    }
  } else {
    $default_source_config = {
      'default' => 'file',
    }
  }

  if $devices_vars_map {
    $csv_map = $devices_map + $devices_vars_map
  } else {
    $csv_map = $devices_map
  }

  if $with_web {
    $web_package_ensure = 'installed'
    $rest_config = '127.0.0.1:8888'
  } else {
    $web_package_ensure = 'absent'
    $rest_config = false
  }

  if $with_service {
    $service_notify = Service['oxidized']
    $service_file_ensure = 'present'
    $service_ensure = 'running'
    $service_enable = true
  } else {
    $service_notify = undef
    $service_file_ensure = 'absent'
    $service_ensure = 'stopped'
    $service_enable = false
  }

  $default_config = delete_undef_values({
    'source' => $default_source_config,
    'rest'   => $rest_config,
    'log'    => $log,
  })
  $_config = $default_config + $config

  contain 'oxidized::user'
  contain 'oxidized::install'
  contain 'oxidized::config'
  contain 'oxidized::service'

  Class['oxidized::user']
  -> Class['oxidized::install']
  -> Class['oxidized::config']
  -> Class['oxidized::service']

  if $manage_repo {
    contain 'oxidized::repo'
    Class['oxidized::repo'] -> Class['oxidized::install']
  }

  $models.each |$name, $model| {
    ::oxidized::model { $name: * => $model }
  }

}
