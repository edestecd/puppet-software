# git.pp
# Install git cli
#

class software::vcsscm::git (
  $ensure          = $software::params::software_ensure,
  $gui             = false,
  $bash_completion = false,
  $bash_prompt     = false,
  $gitconfig       = false,
  $gitignore       = false,
) inherits software::params {

  validate_string($ensure)

  case $::operatingsystem {
    'Ubuntu': {
      package { 'git':
        ensure => $ensure,
      }

      if $gui {
        package { ['gitk', 'git-gui']:
          ensure => $ensure,
        }
      }

      if $bash_completion {
        package { 'bash-completion':
          ensure => $ensure,
        }
      }

      if $bash_prompt {
        vcsrepo { '/opt/bash-git-prompt/':
          ensure   => present,
          provider => git,
          source   => 'https://github.com/magicmonty/bash-git-prompt.git',
          depth    => 1,
        }

        file { '/etc/bash_completion.d/bash-git-prompt':
          ensure => file,
          owner  => 'root',
          group  => 'root',
          mode   => '0644',
          source => 'puppet:///modules/software/vcsscm/git/bash-git-prompt',
        }
      }

      if $gitconfig {
        file { '/etc/gitconfig':
          ensure => file,
          owner  => 'root',
          group  => 'root',
          mode   => '0644',
          source => 'puppet:///modules/software/vcsscm/git/system-gitconfig',
        }

        file { '/etc/skel/.config/git/config':
          ensure => file,
          owner  => 'root',
          group  => 'root',
          mode   => '0644',
          source => 'puppet:///modules/software/vcsscm/git/user-gitconfig',
        }
      }

      if $gitignore {
        file { '/etc/skel/.config/git/ignore':
          ensure => file,
          owner  => 'root',
          group  => 'root',
          mode   => '0644',
          source => 'puppet:///modules/software/vcsscm/git/user-gitignore',
        }
      }
    }
    'windows': {
      package { 'git':
        ensure   => $ensure,
        provider => chocolatey,
      }
    }
    default: {
      fail("The ${name} class is not supported on ${::operatingsystem}.")
    }
  }

}
