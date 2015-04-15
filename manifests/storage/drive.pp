# drive.pp
# Install Google Drive for osx
# https://tools.google.com/dlpage/drive/?hl=en
#

class software::storage::drive (
  $applications_path = $software::params::applications_path,
  $url               = $software::params::drive_url,
) inherits software::params {

  validate_absolute_path($applications_path)
  validate_string($url)

  $app      = 'Google Drive.app'
  $app_path = file_join($applications_path, $app)

  package { 'GoogleDrive':
    ensure   => installed,
    provider => appdmg,
    source   => $url,
  }

}
