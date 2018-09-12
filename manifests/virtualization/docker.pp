# docker.pp
# Install Docker Desktop
# https://www.docker.com/
#
#

class software::virtualization::docker (
  $ensure = $software::params::software_ensure,
) inherits software::params {

  case $facts['os']['name'] {
    'Darwin': {
      package { 'docker':
        ensure   => $ensure,
        provider => brewcask,
      }
    }
    'windows': {
      package { 'docker':
        ensure   => $ensure,
        provider => chocolatey,
      }
    }
    default: {
      fail("The ${name} class is not supported on ${facts['os']['name']}.")
    }
  }

}
