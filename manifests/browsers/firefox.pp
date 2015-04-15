# firefox.pp
# Install Firefox for osx
# http://www.mozilla.org/en-US/firefox/new
#

class software::browsers::firefox (
  $applications_path = $software::params::applications_path,
  $version           = $software::params::firefox_version,
  $url               = $software::params::firefox_url,
) inherits software::params {

  validate_absolute_path($applications_path)
  validate_string($version)
  validate_string($url)

  $app      = 'Firefox.app'
  $app_path = file_join($applications_path, $app)

  package { "Firefox-${version}":
    ensure   => installed,
    provider => appdmg,
    source   => $url,
  }

}
