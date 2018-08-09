# controlplane.pp
# Install ControlPlane for OS X
# http://www.controlplaneapp.com
#

class software::utilities::controlplane (
  $ensure = $software::params::software_ensure,
) inherits software::params {

  case $facts['os']['name'] {
    'Darwin': {
      package { 'controlplane':
        ensure   => $ensure,
        provider => brewcask,
      }
    }
    default: {
      fail("The ${name} class is not supported on ${facts['os']['name']}.")
    }
  }

}
