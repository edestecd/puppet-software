# anvil.pp
# Install Anvil for osx
# http://anvilformac.com
#

class software::webstack::anvil (
  $ensure = $software::params::software_ensure,
  $url    = $software::params::anvil_url,
) inherits software::params {

  validate_string($ensure)

  case $::operatingsystem {
    'Darwin': {
      validate_string($url)

      package { 'Anvil':
        ensure   => $ensure,
        provider => appcompressed,
        source   => $url,
      }
    }
    default: {
      fail("The ${name} class is not supported on ${::operatingsystem}.")
    }
  }

}
