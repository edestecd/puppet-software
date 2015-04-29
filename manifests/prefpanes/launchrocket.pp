# launchrocket.pp
# Install jimbojsb/launchrocket for OS X
# https://github.com/jimbojsb/launchrocket
#

class software::prefpanes::launchrocket (
  $ensure  = $software::params::software_ensure,
  $version = $software::params::launchrocket_version,
  $url     = $software::params::launchrocket_url,
) inherits software::params {

  validate_string($ensure)

  case $::operatingsystem {
    'Darwin': {
      validate_string($version)
      validate_string($url)

      package { "LaunchRocket-${version}":
        ensure   => $ensure,
        provider => prefpanecompressed,
        source   => $url,
      }
    }
    default: {
      fail("The ${name} class is not supported on ${::operatingsystem}.")
    }
  }

}
