# drive.pp
# Install Google Drive for OS X, Ubuntu, or Windows
# https://www.google.com/drive/download
#
# Some third party solutions exist for linux
# http://www.howtogeek.com/196635/an-official-google-drive-for-linux-is-here-sort-of-maybe-this-is-all-well-ever-get
# I choose the most official command line solution:
# https://github.com/odeke-em/drive
#

class software::storage::drive (
  $ensure = $software::params::software_ensure,
  $url    = $software::params::drive_url,
) inherits software::params {

  validate_string($ensure)

  case $::operatingsystem {
    'Darwin': {
      validate_string($url)

      package { 'GoogleDrive':
        ensure   => $ensure,
        provider => appdmg,
        source   => $url,
      }
    }
    'Ubuntu': {
      $apt_ppa_ensure = $ensure ? {
        'installed' => present,
        'latest'    => present,
        default     => $ensure,
      }

      include '::apt'
      apt::ppa { 'ppa:twodopeshaggy/drive':
        ensure         => $apt_ppa_ensure,
        package_manage => true,
      } -> Class['apt::update'] ->

      package { 'drive':
        ensure => $ensure,
      }
    }
    'windows': {
      package { 'googledrive':
        ensure   => $ensure,
        provider => chocolatey,
      }
    }
    default: {
      fail("The ${name} class is not supported on ${::operatingsystem}.")
    }
  }

}
