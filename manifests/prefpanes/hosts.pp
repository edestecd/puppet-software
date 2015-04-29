# hosts.pp
# Install specialunderwear/Hosts.prefpane for OS X
# https://github.com/specialunderwear/Hosts.prefpane
#

class software::prefpanes::hosts (
  $ensure  = $software::params::software_ensure,
  $version = $software::params::hosts_version,
  $url     = $software::params::hosts_url,
) inherits software::params {

  validate_string($ensure)

  case $::operatingsystem {
    'Darwin': {
      validate_string($version)
      validate_string($url)

      package { "Hosts-${version}":
        ensure   => $ensure,
        provider => pkgdmg,
        source   => $url,
      }
    }
    default: {
      fail("The ${name} class is not supported on ${::operatingsystem}.")
    }
  }

}
