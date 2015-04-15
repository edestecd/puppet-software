# chrome.pp
# Install Google Chrome for osx
# https://www.google.com/intl/en_US/chrome/browser
#

class software::browsers::chrome (
  $applications_path = $software::params::applications_path,
  $url               = $software::params::chrome_url,
) inherits software::params {

  validate_absolute_path($applications_path)
  validate_string($url)

  $app      = 'Google Chrome.app'
  $app_path = file_join($applications_path, $app)

  package { 'GoogleChrome':
    ensure   => installed,
    provider => appdmg,
    source   => $url,
  }

}
