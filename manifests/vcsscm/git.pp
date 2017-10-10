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
        # Ensure target path (avoiding to manage base path)
        exec { 'mkdir -p /etc/skel/.config':
          creates => '/etc/skel/.config',
          path    => ['/usr/bin'],
        }
        -> file { '/etc/skel/.config/git':
          ensure => directory,
          owner  => 'root',
          group  => 'root',
          mode   => '0755',
        }
      }

      if $gitconfig {

        if $gitconfig =~ Boolean {
          $gitconfig_system = 'puppet:///modules/software/vcsscm/git/system-gitconfig'
          $gitconfig_user = 'puppet:///modules/software/vcsscm/git/user-gitconfig'
        }
        elsif $gitconfig =~ String {
          $gitconfig_system = false
          $gitconfig_user = $gitconfig
        }
        else {  # must be associative Array otherwise
          $gitconfig_system = $gitconfig['system']
          $gitconfig_user = $gitconfig['user']
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

        if $gitconfig_user {
          file { '/etc/skel/.config/git/config':
            ensure => file,
            owner  => 'root',
            group  => 'root',
            mode   => '0644',
            source => $gitconfig_user,
          }
        }
      }

      if $gitignore {

        if $gitignore =~ Boolean {
          $gitignore_user = 'puppet:///modules/software/vcsscm/git/user-gitignore'
        }
        elsif $gitignore =~ String {
          $gitignore_user = $gitignore
        }
        else {  # must be associative Array otherwise
          $gitignore_user = $gitignore['user']
        }

        if $gitignore_user {
          file { '/etc/skel/.config/git/ignore':
            ensure => file,
            owner  => 'root',
            group  => 'root',
            mode   => '0644',
            source => $gitignore_user,
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
