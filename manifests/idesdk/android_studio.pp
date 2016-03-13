# android_studio.pp
# Install Android Studio for OS X or Windows
# https://developer.android.com/sdk/index.html
#

class software::idesdk::android_studio (
  $ensure  = $software::params::software_ensure,
  $version = $software::params::android_studio_version,
  $url     = $software::params::android_studio_url,
) inherits software::params {

  validate_string($ensure)

  case $::operatingsystem {
    'Darwin': {
      validate_string($version)
      validate_string($url)

      package { "Android-Studio-${version}":
        ensure   => $ensure,
        provider => appdmg,
        source   => $url,
      }
    }
    'windows': {
      package { 'androidstudio':
        ensure   => $ensure,
        provider => chocolatey,
      }
    }
    default: {
      fail("The ${name} class is not supported on ${::operatingsystem}.")
    }
  }

}
