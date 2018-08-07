# sequelpro.pp
# Install Sequel Pro for OS X
# http://www.sequelpro.com
#

class software::database::sequelpro (
  $ensure = $software::params::software_ensure,
) inherits software::params {

  case $facts['os']['name'] {
    'Darwin': {
      package { 'sequel-pro':
        ensure   => $ensure,
        provider => brewcask,
      }
    }
    default: {
      fail("The ${name} class is not supported on ${facts['os']['name']}.")
    }
  }

}
