# synaptic.pp
# Install Synaptic Package Manager for Ubuntu
#

class software::utilities::synaptic (
  $ensure = $software::params::software_ensure,
) inherits software::params {

  case $facts['os']['name'] {
    'Ubuntu': {
      package { 'synaptic':
        ensure => $ensure,
      }
    }
    default: {
      fail("The ${name} class is not supported on ${facts['os']['name']}.")
    }
  }

}
