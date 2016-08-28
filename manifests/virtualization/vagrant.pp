# vagrant.pp
# Install Vagrant for OS X, Ubuntu, or Windows
# https://www.vagrantup.com/
#
#

class software::virtualization::vagrant (
  $ensure = $software::params::software_ensure,
) inherits software::params {

  validate_string($ensure)

  case $::operatingsystem {
    'Darwin', 'Ubuntu': {
      include '::vagrant'
    }
    'windows': {
      package { 'vagrant':
        ensure          => $ensure,
        provider        => chocolatey,
        install_options => ['--allow-empty-checksums'],
      }
    }
    default: {
      fail("The ${name} class is not supported on ${::operatingsystem}.")
    }
  }

}
