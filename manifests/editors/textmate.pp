# textmate.pp
# Install TextMate 2 for OS X
# http://macromates.com
#
# Gets the latest release version...
#

class software::editors::textmate (
  $ensure = $software::params::software_ensure,
  $url    = $software::params::textmate_url,
) inherits software::params {

  validate_string($ensure)

  case $::operatingsystem {
    'Darwin': {
      validate_string($url)

      package { 'TextMate':
        ensure   => $ensure,
        provider => appcompressed,
        flavor   => tbz,
        source   => $url,
      }
    }
    default: {
      fail("The ${name} class is not supported on ${::operatingsystem}.")
    }
  }

}
