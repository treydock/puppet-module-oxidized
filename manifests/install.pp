# @summary Manage oxidized packages
# @api private
class oxidized::install {

  ensure_packages($::oxidized::ruby_dependencies, { 'before' => 'Package[oxidized]' })
  ensure_packages($::oxidized::install_dependencies, { 'before' => 'Package[oxidized]' })

  if $facts.dig('os', 'family') == 'RedHat' {
    if versioncmp($facts['os']['release']['major'], '8') >= 0 {
      $provider = 'system_gem'
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

  package { 'oxidized':
    ensure   => $oxidized::package_ensure,
    provider => $provider,
  }
  -> package { 'oxidized-script':
    ensure   => $oxidized::script_package_ensure,
    provider => $provider,
  }
  package { 'oxidized-web':
    ensure   => $oxidized::_web_package_ensure,
    provider => $provider,
    require  => Package['oxidized'],
  }
}
