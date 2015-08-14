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

  validate_string($ensure, $version, $build, $url)

  case $::operatingsystem {
    'Darwin': {
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
      $apt_source_ensure = $ensure ? {
        'installed' => present,
        'latest'    => present,
        default     => $ensure,
      }

      include '::apt'
      apt::source { 'virtualbox':
        ensure   => $apt_source_ensure,
        location => $url,
        repos    => 'contrib',
        key      => {
          'id'     => '7B0FAB3A13B907435925D9C954422A4B98AB5139',
          'source' => 'https://www.virtualbox.org/download/oracle_vbox.asc',
        },
      } ->

      package { 'dkms': } ->
      package { "virtualbox-${version}": ensure => $ensure }
    }
    default: {
      fail("The ${name} class is not supported on ${::operatingsystem}.")
    }
  }

}
