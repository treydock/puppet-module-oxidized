# @summary Manage repos needed for oxidized
# @api private
class oxidized::repo {
  if $facts['os']['family'] == 'RedHat' and versioncmp($facts['os']['release']['major'], '8') >= 0 {
    include epel
    $oxidized::install_dependencies.each |$package| {
      Yumrepo['epel'] -> Package[$package]
    }
  } elsif $facts['os']['family'] == 'RedHat' {
    if $facts['os']['name'] == 'RedHat' {
      rh_repo { "rhel-server-rhscl-${facts['os']['release']['major']}-rpms":
        ensure => 'present',
        before => Package[$::oxidized::ruby_dependencies],
      }
    } else {
      package { 'centos-release-scl':
        ensure => 'installed',
        before => Package[$::oxidized::ruby_dependencies],
      }
    }
  }
}
