# vim.pp
# Install VI Improved
#

class software::editors::vim (
  $ensure = $software::params::software_ensure,
) inherits software::params {

  validate_string($ensure)

  case $::operatingsystem {
    'Ubuntu': {
      package { 'vim':
        ensure => $ensure,
      }
    }
    'windows': {
      package { 'vim':
        ensure   => $ensure,
        provider => chocolatey,
      }
    }
    default: {
      fail("The ${name} class is not supported on ${::operatingsystem}.")
    }
  }

}
