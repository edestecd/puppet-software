# pdk.pp
# Install Puppet Development Kit
# https://puppet.com/docs/pdk/1.x/pdk.html
#

class software::idesdk::pdk (
  $ensure = $software::params::software_ensure,
) inherits software::params {

  case $facts['os']['name'] {
    'Darwin': {
      package { 'puppetlabs/puppet/pdk':
        ensure   => $ensure,
        provider => brewcask,
      }
    }
    'Debian', 'Ubuntu': {
      package { 'pdk':
        ensure => $ensure,
      }
    }
    'windows': {
      package { 'pdk':
        ensure   => $ensure,
        provider => chocolatey,
      }
    }
    default: {
      fail("The ${name} class is not supported on ${facts['os']['name']}.")
    }
  }

}
