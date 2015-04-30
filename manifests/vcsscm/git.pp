# git.pp
# Install git cli
#

class software::vcsscm::git (
  $ensure = $software::params::software_ensure,
  $gui    = false,
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
    }
    default: {
      fail("The ${name} class is not supported on ${::operatingsystem}.")
    }
  }

}
