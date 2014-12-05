# == Description
#
# OS X settings specific for Stephane
#
class people::stephane::osx {

  boxen::osx_defaults { 'scrollbars always on':
    domain => 'NSGlobalDomain',
    key    => 'AppleShowScrollBars',
    value  => 'Always',
    user   => $::boxen_user,
  }

  boxen::osx_defaults { 'Activity Monitor dock icon':
    domain => 'com.apple.ActivityMonitor',
    key    => 'IconType',
    value  => 4, # 4 - RAM, 5 - CPU
    user   => $::boxen_user,
  }

  boxen::osx_defaults { 'Secure Empty Trash':
    key    => 'EmptyTrashSecurely',
    domain => 'com.apple.finder',
    value  => 'true',
  }

  # Disable GateKeeper
  exec { 'Disable Gatekeeper':
    command => 'spctl --master-disable',
    unless  => 'spctl --status | grep disabled',
  }

  include people::stephane::osx::trackpad::threeFingerDrag

  # Make the top right corner start the screen saver and the bottom left corner launch Mission Control
  class { 'osx::dock::hot_corners':
    bottom_left => "Start Screen Saver"
  }
  class { 'osx::sound::interface_sound_effects':
    enable => false
  }

  osx::recovery_message { 'If this Mac is found, please call 347-437-9708': }

  # include osx::keyboard::capslock_to_control  # disable CAPSLOCK and make it be Ctl instead
  # include osx::global::disable_autocorrect    # disables spelling autocorrection
  # include osx::global::disable_key_press_and_hold         # disable press-and-hold for accented character entry
  include osx::global::disable_remote_control_ir_receiver # disable remote control infrared receiver
  include osx::global::enable_keyboard_control_access     # enables the keyboard for navigating controls in dialogs
  include osx::global::expand_print_dialog    # expand the print dialog by default
  include osx::global::expand_save_dialog     # expand the save dialog by default
  include osx::global::tap_to_click

  # include osx::dock::2d    # use the old flat dock style
  include osx::dock::autohide    # automatically hide the dock
  # include osx::dock::clear_dock    # ensures the dock only contains apps that are running
  # include osx::dock::disable    # disable the dock by setting a long autohide-delay
  # include osx::dock::hide_indicator_lights    # remove the indicator lights below running apps
  include osx::dock::dim_hidden_apps    # dims icons of hidden apps

  include osx::finder::empty_trash_securely    # enable Secure Empty Trash
  # include osx::finder::show_all_on_desktop    # does all of the above
  include osx::finder::show_hard_drives_on_desktop
  include osx::finder::enable_quicklook_text_selection
  include osx::finder::show_external_hard_drives_on_desktop
  include osx::finder::show_hidden_files
  include osx::finder::show_mounted_servers_on_desktop
  include osx::finder::show_removable_media_on_desktop
  include osx::finder::unhide_library    # unsets the hidden flag on ~/Library

  include osx::universal_access::ctrl_mod_zoom    # enables zoom by scrolling while holding Control
  include osx::universal_access::enable_scrollwheel_zoom    # enables zoom using the scroll wheel

  # include osx::disable_app_quarantine # disable the downloaded app quarantine
  include osx::no_network_dsstores    # disable creation of .DS_Store files on network shares
  include osx::software_update        # download and install software updates

  include osx::global::natural_mouse_scrolling
  include osx::dock::magnification
}
