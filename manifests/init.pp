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
# @param config
#   Oxidize config hash
class oxidized (
  Boolean $manage_repo = true,
  Array $ruby_dependencies = [],
  Array $install_dependencies = [],
  String $user = 'oxidized',
  String $user_group = 'oxidized',
  Optional[Integer] $user_uid = undef,
  Optional[Integer] $user_group_gid = undef,
  Stdlib::Absolutepath $user_home = '/home/oxidized',
  Hash $config = {},
) {

  if $facts['os']['family'] == 'RedHat' {
    $bootstrap_command = 'scl enable rh-ruby23 -- oxidized'
  } else {
    $bootstrap_command = 'oxidized'
  }

  contain 'oxidized::user'
  contain 'oxidized::install'
  contain 'oxidized::config'

  Class['oxidized::user']
  -> Class['oxidized::install']
  -> Class['oxidized::config']

  if $manage_repo {
    contain 'oxidized::repo'
    Class['oxidized::repo'] -> Class['oxidized::install']
  }

}
