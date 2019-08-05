# @summary Manage oxidized packages
# @api private
class oxidized::install {

  ensure_packages($::oxidized::ruby_dependencies, { 'before' => 'Package[oxidized]' })
  ensure_packages($::oxidized::install_dependencies, { 'before' => 'Package[oxidized]' })

  if $facts['os']['family'] == 'RedHat' {
    $provider = 'scl_gem'
    file { '/usr/local/bin/scl_gem':
      ensure => 'file',
      owner  => 'root',
      group  => 'root',
      mode   => '0755',
      source => 'puppet:///modules/oxidized/scl_gem',
      before => Package['oxidized'],
    }
  } else {
    $provider = 'gem'
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
