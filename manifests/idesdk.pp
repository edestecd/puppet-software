# idesdk.pp
#
# idesdk group
# Mainly:
#   Integrated Development Environment
#   Software Development Kit
#
#

class software::idesdk (
  $ensure = $software::params::software_ensure,
) inherits software::params {

  class { '::software::idesdk::android_studio':
    ensure => $ensure,
  }

  class { '::software::idesdk::android_tools':
    ensure => $ensure,
  }

}
