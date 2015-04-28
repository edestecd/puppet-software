# sequelpro.pp
# Install Sequel Pro for OS X
# http://www.sequelpro.com
#

class software::database::sequelpro (
  $ensure  = $software::params::software_ensure,
  $version = $software::params::sequelpro_version,
  $url     = $software::params::sequelpro_url,
) inherits software::params {

  validate_string($ensure)

  case $::operatingsystem {
    'Darwin': {
      validate_string($version)
      validate_string($url)

      package { "Sequel-Pro-${version}":
        ensure   => $ensure,
        provider => appdmg,
        source   => $url,
      }
    }
    default: {
      fail("The ${name} class is not supported on ${::operatingsystem}.")
    }
  }

}
