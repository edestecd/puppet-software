# textmate.pp
# Install TextMate 2 for OS X
# http://macromates.com
#
# Gets the latest release version...
#

class software::editors::textmate (
  $ensure = $software::params::software_ensure,
) inherits software::params {

  case $facts['os']['name'] {
    'Darwin': {
      package { 'textmate':
        ensure   => $ensure,
        provider => brewcask,
      }
    }
    default: {
      fail("The ${name} class is not supported on ${facts['os']['name']}.")
    }
  }

}
