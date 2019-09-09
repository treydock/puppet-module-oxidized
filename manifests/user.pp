# @summary Manage Oxidzed user
# @api private
class oxidized::user {
  user { 'oxidized':
    ensure     => 'present',
    name       => $::oxidized::user,
    forcelocal => true,
    shell      => '/bin/bash',
    gid        => 'oxidized',
    uid        => $::oxidized::user_uid,
    home       => $::oxidized::user_home,
    managehome => false,
    system     => true,
  }
  group { 'oxidized':
    ensure     => 'present',
    name       => $::oxidized::user_group,
    forcelocal => true,
    gid        => $::oxidized::user_group_gid,
    system     => true,
  }

  file { $::oxidized::user_home:
    ensure => 'directory',
    owner  => $::oxidized::user,
    group  => $::oxidized::user_group,
    mode   => $::oxidized::user_home_mode,
  }
}
