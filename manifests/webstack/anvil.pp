# anvil.pp
# Install Anvil for osx
# http://anvilformac.com
#

class software::webstack::anvil (
  $ensure = $software::params::software_ensure,
) inherits software::params {

  case $facts['os']['name'] {
    'Darwin': {
      package { 'anvil':
        ensure   => $ensure,
        provider => brewcask,
      }
    }
    default: {
      fail("The ${name} class is not supported on ${facts['os']['name']}.")
    }
  }

}
