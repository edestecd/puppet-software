# android_studio.pp
# Install the Early Access Preview of Android Studio for osx
# http://developer.android.com/sdk/installing/studio.html
#

class software::idesdk::android_studio (
  $applications_path = $software::params::applications_path,
  $version           = $software::params::android_studio_version,
  $url               = $software::params::android_studio_url,
) inherits software::params {

  validate_absolute_path($applications_path)
  validate_string($version)
  validate_string($url)

  $app      = 'Android Studio.app'
  $app_path = file_join($applications_path, $app)

  package { "Android-Studio-${version}":
    ensure   => installed,
    provider => appdmg,
    source   => $url,
  }

}
