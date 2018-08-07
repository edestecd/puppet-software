# launchrocket.pp
# Install jimbojsb/launchrocket for OS X
# https://github.com/jimbojsb/launchrocket
#

class software::prefpanes::launchrocket (
  $ensure = $software::params::software_ensure,
) inherits software::params {

  case $facts['os']['name'] {
    'Darwin': {
      package { 'launchrocket':
        ensure   => $ensure,
        provider => brewcask,
      }
    }
    default: {
      fail("The ${name} class is not supported on ${facts['os']['name']}.")
    }
  }

}
