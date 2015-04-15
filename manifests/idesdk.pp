# idesdk.pp
#
# idesdk group
# Mainly:
#   Integrated Development Environment
#   Software Development Kit
#
#

class software::idesdk (
  $applications_path      = $software::params::applications_path,
  $android_sdk_version    = $software::params::android_sdk_version,
  $android_sdk_url        = $software::params::android_sdk_url,
  $android_studio_version = $software::params::android_studio_version,
  $android_studio_url     = $software::params::android_studio_url,
) inherits software::params {

  class { 'software::idesdk::android_sdk':
    applications_path => $applications_path,
    version           => $android_sdk_version,
    url               => $android_sdk_url,
  }

  class { 'software::idesdk::android_studio':
    applications_path => $applications_path,
    version           => $android_studio_version,
    url               => $android_studio_url,
  }

}
