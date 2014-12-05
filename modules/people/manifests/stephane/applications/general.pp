# == Description
#
# Applications specific for Stephane
# that should be on all his machines.
#
class people::stephane::applications::general {

  include 'chrome'
  include 'dropbox'
  include 'firefox'
  include 'googledrive'
  include 'iterm2::stable'
  include 'alfred'
  include 'nodejs::global'
  include 'nodejs::v0_10'
  include 'packages::truecrypt'
  include 'skype'
  include 'spotify'
  include 'sublime_text'
  include 'virtualbox'
  include 'onepassword'
  include 'appcleaner'
  include 'osxfuse'
  include sshuserconfig

  sshuserconfig::host {
    "prod1":
    remote_hostname => "54.193.175.54",
    remote_username => 'ubuntu',
  }

  sshuserconfig::host {
    "prod2":
    remote_hostname => "54.176.141.43",
    remote_username => 'ubuntu',
  }

}