# pgcommander.pp
# Install PG Commander for OS X
# https://eggerapps.at/pgcommander
#
# The next version (in beta currently):
# https://eggerapps.at/postico
#

class software::database::pgcommander (
  $ensure = $software::params::software_ensure,
) inherits software::params {

  case $facts['os']['name'] {
    'Darwin': {
      package { 'pg-commander':
        ensure   => $ensure,
        provider => brewcask,
      }
    }
    default: {
      fail("The ${name} class is not supported on ${facts['os']['name']}.")
    }
  }

}
