# @summary Manage repos needed for oxidized
# @api private
class oxidized::repo {
  if $facts['os']['family'] == 'RedHat' {
    include epel
    $oxidized::install_dependencies.each |$package| {
      Yumrepo['epel'] -> Package[$package]
    }
    if versioncmp($facts['os']['release']['major'], '8') == 0 {
      package { 'ruby-module':
        ensure      => '2.7',
        name        => 'ruby',
        enable_only => true,
        provider    => 'dnfmodule',
        before      => Package[$oxidized::ruby_dependencies],
      }
    }
    if versioncmp($facts['os']['release']['major'], '7') == 0 {
      if $facts['os']['name'] == 'RedHat' {
        rh_repo { "rhel-server-rhscl-${facts['os']['release']['major']}-rpms":
          ensure => 'present',
          before => Package[$oxidized::ruby_dependencies],
        }
      } else {
        package { 'centos-release-scl':
          ensure => 'installed',
          before => Package[$oxidized::ruby_dependencies],
        }
      }
    }
  }
}
