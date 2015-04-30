# fetch.pp
# Install Fetch for OS X
# http://fetchsoftworks.com
#

class software::storage::fetch (
  $ensure  = $software::params::software_ensure,
  $version = $software::params::fetch_version,
  $url     = $software::params::fetch_url,
) inherits software::params {

  validate_string($ensure)

  case $::operatingsystem {
    'Darwin': {
      validate_string($version)
      validate_string($url)

      package { "Fetch-${version}":
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
