# vlc.pp
# Install VideoLAN Media Player
# http://www.videolan.org/vlc/index.html
#

class software::entertainment::vlc (
  $ensure  = $software::params::software_ensure,
  $version = $software::params::vlc_version,
  $url     = $software::params::vlc_url,
) inherits software::params {

  validate_string($ensure)

  case $::operatingsystem {
    'Darwin': {
      validate_string($version)
      validate_string($url)

      package { "VLC-${version}":
        ensure   => $ensure,
        provider => appdmg,
        source   => $url,
      }
    }
    'Ubuntu': {
      package { 'vlc':
        ensure => $ensure,
      }
    }
    'windows': {
      package { 'vlc':
        ensure   => $ensure,
        provider => chocolatey,
      }
    }
    default: {
      fail("The ${name} class is not supported on ${::operatingsystem}.")
    }
  }

}
