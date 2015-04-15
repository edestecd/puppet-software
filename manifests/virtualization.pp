# virtualization.pp
#
# virtualization group
# Software to manage hosted guest OSes..
#
#

class software::virtualization (
  $applications_path    = $software::params::applications_path,
  $virtualbox_version   = $software::params::virtualbox_version,
  $virtualbox_build     = $software::params::virtualbox_build,
  $virtualbox_url       = $software::params::virtualbox_url,
) inherits software::params {

  class { 'software::virtualization::virtualbox':
    applications_path => $applications_path,
    version           => $virtualbox_version,
    build             => $virtualbox_build,
    url               => $virtualbox_url,
  }

}
