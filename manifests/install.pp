# @summary Manage oxidized packages
# @api private
class oxidized::install {

  ensure_packages($oxidized::ruby_dependencies)
  $oxidized::ruby_dependencies.each |$package| {
    Package[$package] -> Package['oxidized']
  }
  ensure_packages($oxidized::install_dependencies)
  $oxidized::install_dependencies.each |$package| {
    Package[$package] -> Package['oxidized']
  }

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

  if $oxidized::source_ensure {
    vcsrepo { '/usr/local/src/oxidized':
      ensure   => 'present',
      revision => $oxidized::source_ensure,
      source   => $oxidized::source_repo,
      provider => 'git',
    }
    if $provider == 'scl_gem' {
      $install_cmd = 'scl enable rh-ruby23 -- rake install'
      $uninstall_cmd = 'scl enable rh-ruby23 -- gem uninstall oxidized -a --force -x'
      $onlyif_cmd  = 'scl enable rh-ruby23 -- gem list | grep "oxidized "'
    } else {
      $install_cmd = 'rake install'
      $uninstall_cmd = 'gem uninstall oxidized -a --force'
      $onlyif_cmd = 'gem list | grep "oxidized "'
    }
    exec { 'remove oxidized gem':
      path    => '/usr/sbin:/sbin:/usr/bin:/bin',
      command => $uninstall_cmd,
      onlyif  => $onlyif_cmd,
      before  => Exec['install oxidized gem'],
    }
    exec { 'install oxidized gem':
      path        => '/usr/sbin:/sbin:/usr/bin:/bin',
      command     => $install_cmd,
      refreshonly => true,
      subscribe   => Vcsrepo['/usr/local/src/oxidized'],
    }
  } else {
    package { 'oxidized':
      ensure   => $oxidized::package_ensure,
      provider => $provider,
      before   => Package['oxidized-script'],
    }
  }

  package { 'oxidized-script':
    ensure   => $oxidized::script_package_ensure,
    provider => $provider,
  }
  package { 'oxidized-web':
    ensure   => $oxidized::_web_package_ensure,
    provider => $provider,
    require  => Package['oxidized'],
  }
}
