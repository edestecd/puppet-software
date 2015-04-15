# sequelpro.pp
# Install Sequel Pro for osx
# http://www.sequelpro.com
#

class software::database::sequelpro (
  $applications_path = $software::params::applications_path,
  $version           = $software::params::sequelpro_version,
  $url               = $software::params::sequelpro_url,
) inherits software::params {

  validate_absolute_path($applications_path)
  validate_string($version)
  validate_string($url)

  $app      = 'Sequel Pro.app'
  $app_path = file_join($applications_path, $app)

  package { "Sequel-Pro-${version}":
    ensure   => installed,
    provider => appdmg,
    source   => $url,
  }

}
