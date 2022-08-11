# @summary Manage oxidized packages
# @api private
class oxidized::install {

  ensure_packages($oxidized::ruby_dependencies)
  $oxidized::ruby_dependencies.each |$package| {
    if $oxidized::source_ensure {
      Package[$package] -> Vcsrepo[$oxidized::src_dir]
    } else {
      Package[$package] -> Package['oxidized']
    }
  }
  ensure_packages($oxidized::install_dependencies)
  $oxidized::install_dependencies.each |$package| {
    if $oxidized::source_ensure {
      Package[$package] -> Vcsrepo[$oxidized::src_dir]
    } else {
      Package[$package] -> Package['oxidized']
    }
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
      }
      if ! $oxidized::source_ensure {
        File['/usr/local/bin/scl_gem'] -> Package['oxidized']
      }
    }
  } else {
    $provider = 'system_gem'
  }

  if $oxidized::source_ensure {
    vcsrepo { $oxidized::src_dir:
      ensure   => 'present',
      revision => $oxidized::source_ensure,
      source   => $oxidized::source_repo,
      provider => 'git',
    }
    if $provider == 'scl_gem' {
      $build_cmd = 'scl enable rh-ruby27 -- rake build'
      $install_cmd = 'scl enable rh-ruby27 -- gem install --local pkg/oxidized*.gem'
      $dep_cmd = 'scl enable rh-ruby27 -- gem install -g'
      $uninstall_cmd = 'scl enable rh-ruby27 -- gem uninstall oxidized -a --force -x'
      $onlyif_cmd  = 'scl enable rh-ruby27 -- gem list | grep "oxidized "'
    } else {
      $build_cmd = undef
      $install_cmd = 'rake install:local'
      $dep_cmd = 'gem install -g'
      $uninstall_cmd = 'gem uninstall oxidized -a --force'
      $onlyif_cmd = 'gem list | grep "oxidized "'
    }
    exec { 'remove oxidized gem':
      path        => '/usr/sbin:/sbin:/usr/bin:/bin',
      command     => $uninstall_cmd,
      refreshonly => true,
      onlyif      => $onlyif_cmd,
      logoutput   => true,
      subscribe   => Vcsrepo[$oxidized::src_dir],
      before      => [
        Exec['install oxidized dependencies'],
        Exec['install oxidized gem'],
      ],
    }
    exec { 'install oxidized dependencies':
      path        => '/usr/sbin:/sbin:/usr/bin:/bin',
      cwd         => $oxidized::src_dir,
      command     => $dep_cmd,
      refreshonly => true,
      logoutput   => true,
      subscribe   => Vcsrepo[$oxidized::src_dir],
      before      => Exec['install oxidized gem'],
    }
    if $build_cmd {
      exec { 'build oxidized gem':
        path        => '/usr/sbin:/sbin:/usr/bin:/bin',
        cwd         => $oxidized::src_dir,
        command     => $build_cmd,
        refreshonly => true,
        logoutput   => true,
        subscribe   => Vcsrepo[$oxidized::src_dir],
        require     => Exec['install oxidized dependencies'],
        before      => Exec['install oxidized gem'],
      }
    }
    exec { 'install oxidized gem':
      path        => '/usr/sbin:/sbin:/usr/bin:/bin',
      cwd         => $oxidized::src_dir,
      command     => $install_cmd,
      refreshonly => true,
      logoutput   => true,
      subscribe   => Vcsrepo[$oxidized::src_dir],
      before      => [
        Package['oxidized-script'],
        Package['oxidized-web'],
      ]
    }
  } else {
    package { 'oxidized':
      ensure   => $oxidized::package_ensure,
      provider => $provider,
      before   => [
        Package['oxidized-script'],
        Package['oxidized-web'],
      ],
    }
  }

  package { 'oxidized-script':
    ensure   => $oxidized::script_package_ensure,
    provider => $provider,
  }
  package { 'oxidized-web':
    ensure   => $oxidized::_web_package_ensure,
    provider => $provider,
  }
}
