# virtualization.pp
#
# virtualization group
# Software to manage hosted guest OSes..
#
#

class software::virtualization (
  $ensure             = $software::params::software_ensure,
  $virtualbox_version = $software::params::virtualbox_version,
  $virtualbox_build   = $software::params::virtualbox_build,
  $virtualbox_url     = $software::params::virtualbox_url,
) inherits software::params {

  class { '::software::virtualization::virtualbox':
    ensure  => $ensure,
    version => $virtualbox_version,
    build   => $virtualbox_build,
    url     => $virtualbox_url,
  }

}
