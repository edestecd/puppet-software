# android_studio.pp
# Install Android Studio for OS X or Windows
# https://developer.android.com/sdk/index.html
#

class software::idesdk::android_studio (
  $ensure = $software::params::software_ensure,
) inherits software::params {

  case $facts['os']['name'] {
    'Darwin': {
      package { 'android-studio':
        ensure   => $ensure,
        provider => brewcask,
      }
    }
    'windows': {
      package { 'androidstudio':
        ensure   => $ensure,
        provider => chocolatey,
      }
    }
    default: {
      fail("The ${name} class is not supported on ${facts['os']['name']}.")
    }
  }

}
