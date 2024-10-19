# @summary Manage oxidized packages
# @api private
class oxidized::install {
  stdlib::ensure_packages($oxidized::ruby_dependencies)
  $oxidized::ruby_dependencies.each |$package| {
    Package[$package] -> Package['oxidized']
  }
  stdlib::ensure_packages($oxidized::install_dependencies)
  $oxidized::install_dependencies.each |$package| {
    Package[$package] -> Package['oxidized']
  }

  package { 'oxidized':
    ensure   => $oxidized::package_ensure,
    provider => 'gem',
    command  => '/usr/bin/gem',
  }
  -> package { 'oxidized-script':
    ensure   => $oxidized::script_package_ensure,
    provider => 'gem',
    command  => '/usr/bin/gem',
  }
  package { 'oxidized-web':
    ensure   => $oxidized::_web_package_ensure,
    provider => 'gem',
    command  => '/usr/bin/gem',
    require  => Package['oxidized'],
  }
}
