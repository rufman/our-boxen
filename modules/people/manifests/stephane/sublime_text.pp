# == Description
#
# Sublime Text 2 settings specific forS tephane.
#
class people::stephane::sublime_text {

  include 'sublime_text'

  $home = "/Users/${::boxen_user}"

  file { "${home}/Library/Application Support/Sublime Text 2/Packages/User":
    ensure => 'directory',
    owner  => $::boxen_user,
    mode   => '0755',
  }
  ->
  file { "${home}/Library/Application Support/Sublime Text 2/Packages/User/Preferences.sublime-settings":
    source  => 'puppet:///modules/people/stephane/sublime-settings',
  }

  file { "${home}/Library/Application Support/Sublime Text 2/Packages/User":
    ensure => 'directory',
    owner  => $::boxen_user,
    mode   => '0755',
  }
  ->
  file { "${home}/Library/Application Support/Sublime Text 2/Packages/User/SublimePython.sublime-settings":
    source  => 'puppet:///modules/people/stephane/SublimePython.sublime-settings',
  }

  file { "${home}/Library/Application Support/Sublime Text 2/Packages/User":
    ensure => 'directory',
    owner  => $::boxen_user,
    mode   => '0755',
  }
  ->
  file { "${home}/Library/Application Support/Sublime Text 2/Packages/User/Linter.sublime-keymap":
    source  => 'puppet:///modules/people/stephane/Default (OSX).sublime-keymap',
  }

  file { "${home}/Library/Application Support/Sublime Text 2/Packages/User":
    ensure => 'directory',
    owner  => $::boxen_user,
    mode   => '0755',
  }
  ->
  file { "${home}/Library/Application Support/Sublime Text 2/Packages/User/Base File.sublime-settings":
    source  => 'puppet:///modules/people/stephane/Base File.sublime-settings',
  }

}
