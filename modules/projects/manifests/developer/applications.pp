# == Description
#
# Applications specific for the 'developer' project.
#
class projects::developer::applications {

  include 'chrome'
  include 'firefox'
  include 'docker'
  include 'mysql'
  include 'python'
  include 'git'
  include 'dash'
  include 'iterm2::stable'
  include 'p4merge'
  include 'sourcetree'
  include 'sublime_text'
  include 'virtualbox'
  include 'wget'
  include 'vim'
  include 'nmap'
  include 'slack'
  include 'memcached'

}
