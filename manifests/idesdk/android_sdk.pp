# android_sdk.pp
# Install the Android SDK for osx
# http://developer.android.com/sdk/index.html
#

class software::idesdk::android_sdk (
  $applications_path = $software::params::applications_path,
  $version           = $software::params::android_sdk_version,
  $url               = $software::params::android_sdk_url,
) inherits software::params {

  validate_absolute_path($applications_path)
  validate_string($version)
  validate_string($url)

  $app      = "adt-bundle-mac-x86_64-${version}"
  $app_path = file_join($applications_path, $app)

  package { "adt-bundle-mac-x86_64-${version}":
    ensure   => installed,
    provider => appcompressed,
    source   => $url,
  }

}
