# tfenv.pp
# Install Terraform version manager
# https://github.com/Zordrak/tfenv
#

class software::idesdk::tfenv (
  $ensure = $software::params::software_ensure,
) inherits software::params {

  case $facts['os']['name'] {
    'Darwin': {
      package { 'tfenv':
        ensure   => $ensure,
        provider => brew,
      }
    }
    default: {
      fail("The ${name} class is not supported on ${facts['os']['name']}.")
    }
  }

}
