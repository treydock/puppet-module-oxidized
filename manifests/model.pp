#
# @summary Manage oxidized models
#
#
# @param source
#   Source of model
#
define oxidized::model (
  String $source,
) {

  include ::oxidized

  $path = "${::oxidized::user_home}/.config/oxidized/model/${name}.rb"

  file { "model-${name}":
    ensure    => 'file',
    path      => $path,
    owner     => $::oxidized::user,
    group     => $::oxidized::user_group,
    mode      => '0644',
    source    => $source,
    show_diff => $::oxidized::show_diff,
  }

}
