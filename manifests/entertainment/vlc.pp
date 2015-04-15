# vlc.pp
# Install VideoLAN Media Player
# http://www.videolan.org/vlc/index.html
#

class software::entertainment::vlc (
  $applications_path = $software::params::applications_path,
  $version           = $software::params::vlc_version,
  $url               = $software::params::vlc_url,
) inherits software::params {

  validate_absolute_path($applications_path)
  validate_string($version)
  validate_string($url)

  $app      = 'VLC.app'
  $app_path = file_join($applications_path, $app)

  package { "VLC-${version}":
    ensure   => installed,
    provider => appdmg,
    source   => $url,
  }

}
