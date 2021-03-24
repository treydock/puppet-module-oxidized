# @summary Manage oxidized service
# @api private
class oxidized::service {
  assert_private()
<<<<<<< HEAD

  ::systemd::unit_file { 'oxidized.service':
    ensure  => $::oxidized::service_file_ensure,
    content => template('oxidized/oxidized.service.erb'),
    notify  => Service['oxidized'],
=======
  }

  service { 'oxidized':
    ensure     => $::oxidized::service_ensure,
    enable     => $::oxidized::service_enable,
    hasstatus  => true,
    hasrestart => true,
  }
}
