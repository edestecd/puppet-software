# virtualbox.pp
# Install Virtual Box for osx
# https://www.virtualbox.org/
#
#

class software::virtualization::virtualbox (
  $applications_path = $software::params::applications_path,
  $version           = $software::params::virtualbox_version,
  $build             = $software::params::virtualbox_build,
  $url               = $software::params::virtualbox_url,
) inherits software::params {

  validate_absolute_path($applications_path)
  validate_string($version)
  validate_string($build)
  validate_string($url)

  $app      = 'VirtualBox.app'
  $app_path = file_join($applications_path, $app)

  exec { 'KillVirtualBoxProcesses':
    command     => 'pkill "VBoxXPCOMIPCD" || true && pkill "VBoxSVC" || true && pkill "VBoxHeadless" || true',
    path        => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    refreshonly => true,
  }

  package { "VirtualBox-${version}-${build}":
    ensure   => installed,
    provider => pkgdmg,
    source   => $url,
    require  => Exec['KillVirtualBoxProcesses'],
  }

}
