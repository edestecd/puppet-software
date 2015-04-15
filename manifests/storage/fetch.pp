# fetch.pp
# Install Fetch for osx
# http://fetchsoftworks.com
#

class software::storage::fetch (
  $applications_path = $software::params::applications_path,
  $version           = $software::params::fetch_version,
  $url               = $software::params::fetch_url,
) inherits software::params {

  validate_absolute_path($applications_path)
  validate_string($version)
  validate_string($url)

  $app      = 'Fetch.app'
  $app_path = file_join($applications_path, $app)

  package { "Fetch-${version}":
    ensure   => installed,
    provider => appdmg,
    source   => $url,
  }

}
