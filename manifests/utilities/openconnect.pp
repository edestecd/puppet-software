# openconnect.pp
# Install Open Client for Cisco AnyConnect VPN for OS X or Ubuntu
# Also installs the Network Management Plugin for graphical configuration
#

class software::utilities::openconnect (
  $ensure = $software::params::software_ensure,
) inherits software::params {

  validate_string($ensure)

  case $::operatingsystem {
    'Darwin': {
      include '::homebrew'
      package { 'openconnect':
        ensure   => $ensure,
        provider => brew,
      }
    }
    'Ubuntu': {
      package { 'network-manager-openconnect-gnome':
        ensure => $ensure,
      }
    }
    default: {
      fail("The ${name} class is not supported on ${::operatingsystem}.")
    }
  }

}
