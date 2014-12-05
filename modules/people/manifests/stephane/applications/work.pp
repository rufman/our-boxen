# == Description
#
# Applications specific for Stephane
# that should be on all his machines.
#
class people::stephane::applications::general {

  include 'chrome'
  include 'docker'
  include 'dropbox'
  include 'firefox'
  include 'git'
  include 'googledrive'
  include 'heroku'
  include 'iterm2::stable'
  include 'alfred'
  include 'nodejs::global'
  include 'nodejs::v0_10'
  include 'packages::truecrypt'
  include 'skype'
  include 'sourcetree'
  include 'spotify'
  include 'sublime_text'
  include 'tmux'
  include 'mailbox'
  include 'virtualbox'
  include 'openoffice'
  include 'openssl'
  include 'inkscape'
  include python
  include python::virtualenvwrapper

}