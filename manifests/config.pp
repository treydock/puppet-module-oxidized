# @summary Manage oxidized configs
# @api private
class oxidized::config {

  file { '/etc/oxidized':
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  exec { 'bootstrap-oxidized':
    environment => [
      "HOME=${::oxidized::user_home}",
      "OXIDIZED_HOME=${::oxidized::user_home}/.config/oxidized",
    ],
    path        => '/usr/bin:/bin:/usr/sbin:/sbin',
    command     => $::oxidized::bootstrap_command,
    creates     => "${::oxidized::user_home}/.config/oxidized/config",
    user        => $::oxidized::user,
  }
  -> file { '/etc/oxidized/config':
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => "${::oxidized::user_home}/.config/oxidized/config",
    replace => false,
  }

  $config_yaml = to_yaml($::oxidized::_config)
  file { "${::oxidized::user_home}/.config/oxidized/config":
    ensure  => 'file',
    owner   => $::oxidized::user,
    group   => $::oxidized::user_group,
    mode    => '0644',
    content => "# File managed by Puppet\n${config_yaml}",
    require => Exec['bootstrap-oxidized'],
  }

  if $::oxidized::source_type == 'csv' {
    $router_db_contents = $::oxidized::devices.map |$d| {
      "${d['name']}:${d['model']}"
    }
    file { $::oxidized::router_db:
      ensure  => 'file',
      owner   => $::oxidized::user,
      group   => $::oxidized::user_group,
      mode    => '0644',
      content => join($router_db_contents, "\n"),
      require => Exec['bootstrap-oxidized'],
    }
  }

}
