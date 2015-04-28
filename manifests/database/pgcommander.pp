# pgcommander.pp
# Install PG Commander for OS X
# https://eggerapps.at/pgcommander
#
# The next version (in beta currently):
# https://eggerapps.at/postico
#

class software::database::pgcommander (
  $ensure  = $software::params::software_ensure,
  $version = $software::params::pgcommander_version,
  $url     = $software::params::pgcommander_url,
) inherits software::params {

  validate_string($ensure)

  case $::operatingsystem {
    'Darwin': {
      validate_string($version)
      validate_string($url)

      package { "PGCommander-${version}":
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
