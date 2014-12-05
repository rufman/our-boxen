# == Description
#
# Applications specific for the 'fe_developer' project.
#
class projects::fe_developer::applications {

  include 'chrome'
  include 'firefox'
  include 'docker'
  include 'mysql'
  include 'python'
  include 'git'
  include 'iterm2::stable'
  include 'p4merge'
  include 'sourcetree'
  include 'sublime_text'
  include 'virtualbox'
  include 'wget'
  include 'slack'
  include 'nmap'
  include 'java'
  # include 'nginx'
  include 'android'
  include 'android::19'
  include 'android::10'
  include 'android::8'
  include 'nodejs::v0_10'
  include 'nvm'

}
