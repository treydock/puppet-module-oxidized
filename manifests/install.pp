# @summary Manage oxidized packages
# @api private
class oxidized::install {

  ensure_packages($::oxidized::ruby_dependencies, { 'before' => 'Package[oxidized]' })
  ensure_packages($::oxidized::install_dependencies, { 'before' => 'Package[oxidized]' })

  if $facts.dig('os', 'family') == 'RedHat' {
    if versioncmp($::operatingsystemrelease, '8') >= 0 {
      $provider = 'system_gem'
      # libssh2 is not in repos for RHEL8
      package{'libssh2':
        ensure   => present,
        provider => 'rpm',
        source   => 'http://mirror.city-fan.org/ftp/contrib/libraries/libssh2-1.9.0-7.0.cf.rhel8.x86_64.rpm',
      }
      ~> package{'libssh2-devel':
        ensure   => present,
        provider => 'rpm',
        source   => 'http://mirror.city-fan.org/ftp/contrib/libraries/libssh2-devel-1.9.0-7.0.cf.rhel8.x86_64.rpm',
      }
    }
    else {
      $provider = 'scl_gem'
      file { '/usr/local/bin/scl_gem':
        ensure => 'file',
        owner  => 'root',
        group  => 'root',
        mode   => '0755',
        source => 'puppet:///modules/oxidized/scl_gem',
        before => Package['oxidized'],
      }
    }
  } else {
    $provider = 'system_gem'
  }

  # Only necessary until released: https://github.com/ytti/oxidized/pull/2050
  package { 'rugged':
    ensure   => '0.28.4.1',
    provider => $provider,
    before   => Package['oxidized'],
    require  => Package[$oxidized::ruby_dependencies + $oxidized::install_dependencies],
  }
  package { 'oxidized':
    ensure   => 'installed',
    provider => $provider,
  }
  -> package { 'oxidized-script':
    ensure   => 'installed',
    provider => $provider,
  }
  package { 'oxidized-web':
    ensure   => $::oxidized::web_package_ensure,
    provider => $provider,
    require  => Package['oxidized'],
  }
}
