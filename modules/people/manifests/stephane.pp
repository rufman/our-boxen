# == Description
#
# Machine configuration specific for Stephane Rufer.
#
class people::stephane {

  include people::stephane::dotfiles
  include people::stephane::bin
  include people::stephane::applications
  include people::stephane::git
  include people::stephane::sublime_text
  include people::stephane::osx

}