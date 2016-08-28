# virtualbox.pp
# Install Virtual Box for OS X, Ubuntu, or Windows
# https://www.virtualbox.org
#
#

class software::virtualization::virtualbox (
  $ensure  = $software::params::software_ensure,
  $version = $software::params::virtualbox_version,
  $build   = $software::params::virtualbox_build,
  $url     = $software::params::virtualbox_url,
  $key     = $software::params::virtualbox_key,
) inherits software::params {

  validate_string($ensure)

  case $::operatingsystem {
    'Darwin': {
      validate_string($version, $build, $url)

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
      validate_string($version, $build, $url)
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
        key      => $key,
      } -> Class['apt::update'] ->

      package { 'dkms': } ->
      package { "virtualbox-${version}": ensure => $ensure }
    }
    'windows': {
      package { 'virtualbox':
        ensure          => $ensure,
        provider        => chocolatey,
        install_options => ['--allow-empty-checksums'],
      }
    }
    default: {
      fail("The ${name} class is not supported on ${::operatingsystem}.")
    }
  }

}
