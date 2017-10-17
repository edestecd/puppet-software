# git.pp
# Install git cli, optional tab completion, config and ignore files
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

      if $gitconfig or $gitignore {

        if !defined(File['/etc/skel/.config']) {
          file { '/etc/skel/.config':
            ensure => directory,
            owner  => 'root',
            group  => 'root',
            mode   => '0755',
          }
        }

        if !defined(File['/etc/skel/.config/git']) {
          file { '/etc/skel/.config/git':
            ensure  => directory,
            owner   => 'root',
            group   => 'root',
            mode    => '0755',
            require => File['/etc/skel/.config'],
          }
        }
      }

      if $gitconfig {

        $gitconfig_system = $gitconfig ? {
          Boolean => 'puppet:///modules/software/vcsscm/git/system-gitconfig',
          String  => false,  # a string will only set user config
          Hash    => $gitconfig['system'],
          default => fail('$gitconfig must be one of (Boolean, String, Hash)'),
        }

        if $gitconfig_system {

          file { '/etc/gitconfig':
            ensure => file,
            owner  => 'root',
            group  => 'root',
            mode   => '0644',
            source => $gitconfig_system,
          }
        }

        $gitconfig_user = $gitconfig ? {
          Boolean => 'puppet:///modules/software/vcsscm/git/user-gitconfig',
          String  => $gitconfig,
          Hash    => $gitconfig['user'],
          default => fail('$gitconfig must be one of (Boolean, String, Hash)'),
        }

        if $gitconfig_user {

          file { '/etc/skel/.config/git/config':
            ensure  => file,
            owner   => 'root',
            group   => 'root',
            mode    => '0644',
            source  => $gitconfig_user,
            require => File['/etc/skel/.config/git'],
          }
        }
      }

      if $gitignore {

        $gitignore_user = $gitignore ? {
          Boolean => 'puppet:///modules/software/vcsscm/git/user-gitignore',
          String  => $gitignore,
          Hash    => $gitignore['user'],
          default => fail('$gitignore must be one of (Boolean, String, Hash)'),
        }

        if $gitignore_user {

          file { '/etc/skel/.config/git/ignore':
            ensure  => file,
            owner   => 'root',
            group   => 'root',
            mode    => '0644',
            source  => $gitignore_user,
            require => File['/etc/skel/.config/git'],
          }
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
