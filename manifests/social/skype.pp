# skype.pp
# Install Skype for OS X, Ubuntu, or Windows
# http://www.skype.com/en
#

class software::social::skype (
  $ensure  = $software::params::software_ensure,
  $version = $software::params::skype_version,
  $url     = $software::params::skype_url,
) inherits software::params {

  validate_string($ensure)

  case $::operatingsystem {
    'Darwin': {
      validate_string($version)
      validate_string($url)

      package { "Skype-${version}":
        ensure   => $ensure,
        provider => appdmg,
        source   => $url,
      }
    }
    'Ubuntu': {
      $apt_source_ensure = $ensure ? {
        'installed' => present,
        'latest'    => present,
        default     => $ensure,
      }

      include '::apt'
      apt::source { 'skype-partner':
        ensure      => $apt_source_ensure,
        location    => 'http://archive.canonical.com/ubuntu',
        repos       => 'partner',
        include_src => false,
      } -> Class['apt::update'] ->

      package { 'skype':
        ensure => $ensure,
      }
    }
    'windows': {
      package { 'skype':
        ensure   => $ensure,
        provider => chocolatey,
      }
    }
    default: {
      fail("The ${name} class is not supported on ${::operatingsystem}.")
    }
  }

}
