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
        ensure      => '3.0',
        name        => 'ruby',
        enable_only => true,
        provider    => 'dnfmodule',
        before      => Package[$oxidized::ruby_dependencies],
      }
    }
  }
}
