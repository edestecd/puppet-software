# awscli.pp
# Install AWS Command Line Interface
# https://aws.amazon.com/cli
#

class software::idesdk::awscli (
  $ensure = $software::params::software_ensure,
) inherits software::params {

  case $facts['os']['name'] {
    'Darwin': {
      package { 'awscli':
        ensure   => $ensure,
        provider => brew,
      }
    }
    default: {
      fail("The ${name} class is not supported on ${facts['os']['name']}.")
    }
  }

}
