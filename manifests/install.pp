# @summary Manage oxidized packages
# @api private
class oxidized::install {
  stdlib::ensure_packages($oxidized::ruby_dependencies)
  $oxidized::ruby_dependencies.each |$package| {
    Package[$package] -> Package['oxidized']
    Package[$package] -> Exec['rugged-install']
  }
  stdlib::ensure_packages($oxidized::install_dependencies)
  $oxidized::install_dependencies.each |$package| {
    Package[$package] -> Package['oxidized']
    Package[$package] -> Exec['rugged-install']
  }

  package { 'oxidized':
    ensure   => $oxidized::package_ensure,
    provider => 'gem',
    command  => '/usr/bin/gem',
    notify   => Service['oxidized'],
  }
  -> package { 'oxidized-script':
    ensure   => $oxidized::script_package_ensure,
    provider => 'gem',
    command  => '/usr/bin/gem',
    notify   => Service['oxidized'],
  }
  package { 'oxidized-web':
    ensure   => $oxidized::_web_package_ensure,
    provider => 'gem',
    command  => '/usr/bin/gem',
    require  => Package['oxidized'],
    notify   => Service['oxidized'],
  }

  # Install rugged with SSH support
  exec { 'rugged-install':
    path      => '/usr/bin:/bin:/usr/sbin:/sbin',
    command   => "gem install --no-document rugged -v ${oxidized::rugged_version} -- --with-ssh",
    unless    => "gem list rugged | grep '${oxidized::rugged_version}'",
    logoutput => 'on_failure',
    before    => Package['oxidized'],
    notify    => Service['oxidized'],
  }
}
