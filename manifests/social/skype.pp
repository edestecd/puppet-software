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
    'Debian', 'Ubuntu': {
      $apt_source_ensure = $ensure ? {
        'installed' => present,
        'latest'    => present,
        default     => $ensure,
      }

      include '::apt'
      apt::source { 'skype-stable':
        ensure       => $apt_source_ensure,
        comment      => 'Skype APT sources for any Debian-based distribution, including Ubuntu',
        location     => 'https://repo.skype.com/deb',
        release      => 'stable',
        repos        => 'main',
        architecture => 'amd64',
        key          => {
          'id'     => 'D4040146BE3972509FD57FC71F3045A5DF7587C3',
          'source' => 'https://repo.skype.com/data/SKYPE-GPG-KEY',
        },
      } -> Class['apt::update'] ->

      package { 'skypeforlinux':
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
