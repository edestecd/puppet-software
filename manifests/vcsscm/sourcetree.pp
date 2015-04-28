# sourcetree.pp
# Install SourceTree for OS X
# http://www.sourcetreeapp.com
#

class software::vcsscm::sourcetree (
  $ensure  = $software::params::software_ensure,
  $version = $software::params::sourcetree_version,
  $url     = $software::params::sourcetree_url,
) inherits software::params {

  validate_string($ensure)

  case $::operatingsystem {
    'Darwin': {
      validate_string($version)
      validate_string($url)

      package { "SourceTree-${version}":
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
