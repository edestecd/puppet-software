# virtualbox.pp
# Install Virtual Box for OS X or Ubuntu
# https://www.virtualbox.org
#
#

class software::virtualization::virtualbox (
  $ensure  = $software::params::software_ensure,
  $version = $software::params::virtualbox_version,
  $build   = $software::params::virtualbox_build,
  $url     = $software::params::virtualbox_url,
) inherits software::params {

  validate_string($ensure)

  case $::operatingsystem {
    'Darwin': {
      validate_string($version)
      validate_string($build)
      validate_string($url)

      exec { 'KillVirtualBoxProcesses':
        command     => 'pkill "VBoxXPCOMIPCD" || true && pkill "VBoxSVC" || true && pkill "VBoxHeadless" || true',
        path        => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
        refreshonly => true,
      }

      package { "VirtualBox-${version}-${build}":
        ensure   => $ensure,
        provider => pkgdmg,
        source   => $url,
        require  => Exec['KillVirtualBoxProcesses'],
      }
    }
    'Ubuntu': {
      package { 'virtualbox-qt':
        ensure => $ensure,
      }
    }
    default: {
      fail("The ${name} class is not supported on ${::operatingsystem}.")
    }
  }

}
