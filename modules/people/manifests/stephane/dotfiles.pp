# == Description
#
# "Dot files" for Stephane
#
# == Assumptions
#
#
class people::stephane::dotfiles {
  include git

  $home = "/Users/${::boxen_user}"


  file { "${home}/.gitconfig":
    # This should probably be managed using the git module instead...
    source => 'puppet:///modules/people/stephane/gitconfig',
  }

  file { "${home}/.aliases":
    source => 'puppet:///modules/people/stephane/aliases',
  }

  file { "${home}/.bash_profile":
    source => 'puppet:///modules/people/stephane/bash_profile',
  }

  file { "${home}/.bashrc":
    source => 'puppet:///modules/people/stephane/bashrc',
  }

  file { "${home}/.exports":
    source => 'puppet:///modules/people/stephane/exports',
  }

  file { "${home}/.functions":
    source => 'puppet:///modules/people/stephane/functions',
  }

  file { "${home}/.vimrc":
    source => 'puppet:///modules/people/stephane/vimrc',
  }

  file { "${home}/bash_prompt":
    source => 'puppet:///modules/people/stephane/bash_prompt',
  }

  file { "${home}/deploy.py":
    source => 'puppet:///modules/people/stephane/deploy.py',
  }

}
