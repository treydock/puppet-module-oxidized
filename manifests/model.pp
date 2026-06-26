#
# @summary Manage oxidized models
#
# @param ensure
#   Whether to add or remove the model
#
# @param source
#   Source of model
#
define oxidized::model (
  Enum['present', 'absent'] $ensure = 'present',
  String $source,
) {
  include oxidized

  if $ensure == 'absent' {
    $file_ensure = 'absent'
  } else {
    $file_ensure = 'file'
  }

  $path = "${oxidized::user_home}/.config/oxidized/model/${name}.rb"

  file { "model-${name}":
    ensure    => $file_ensure,
    path      => $path,
    owner     => $oxidized::user,
    group     => $oxidized::user_group,
    mode      => '0644',
    source    => $source,
    show_diff => $oxidized::show_diff,
    notify    => Service['oxidized'],
  }
}
