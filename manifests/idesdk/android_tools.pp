# android_tools.pp
# Install Android Tools
# adb and fastboot command line tools
#

class software::idesdk::android_tools (
  $ensure = $software::params::software_ensure,
) inherits software::params {

  validate_string($ensure)

  case $::operatingsystem {
    'Ubuntu': {
      package { ['android-tools-adb', 'android-tools-fastboot']:
        ensure => $ensure,
      }
    }
    'windows': {
      package { 'adb':
        ensure   => $ensure,
        provider => chocolatey,
      }
    }
    default: {
      fail("The ${name} class is not supported on ${::operatingsystem}.")
    }
  }

}
