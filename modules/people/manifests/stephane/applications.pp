# == Description
#
# Applications specific for Stephane Rufer.
#
# == Parameters
#
# [*system_roles*]
#   An array of the roles that this system participates in.
#   Valid values are 'work' and 'personal'. If not passed in,
#   it is looked up in hiera using the key 'people::stephane::system_roles'
#
class people::stephane::applications (
  $system_roles = undef
) {

  $_system_roles = hiera_array('people::stephane::system_roles', [])
  $roles = $system_roles ? { undef => $_system_roles, default => $system_roles}

  include people::stephane::applications::general

  if member($roles, 'work') {
    include 'people::stephane::applications::work'
  }
  elsif member($roles, 'personal') {
    include 'people::stephane::applications::personal'
  }

}