# idesdk.pp
#
# idesdk group
# Mainly:
#   Integrated Development Environment
#   Software Development Kit
#
#

class software::idesdk (
  $ensure                 = $software::params::software_ensure,
  $android_studio_version = $software::params::android_studio_version,
  $android_studio_url     = $software::params::android_studio_url,
) inherits software::params {

  class { '::software::idesdk::android_studio':
    ensure  => $ensure,
    version => $android_studio_version,
    url     => $android_studio_url,
  }

  class { '::software::idesdk::android_tools':
    ensure => $ensure,
  }

}
