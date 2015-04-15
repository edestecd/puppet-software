# textmate.pp
# Install TextMate 2 for osx
# http://macromates.com
#
# Gets the latest release version...
#

class software::editors::textmate (
  $applications_path = $software::params::applications_path,
  $url               = $software::params::textmate_url,
) inherits software::params {

  validate_absolute_path($applications_path)
  validate_string($url)

  $app      = 'TextMate.app'
  $app_path = file_join($applications_path, $app)

  package { 'TextMate':
    ensure   => installed,
    provider => appcompressed,
    flavor   => tbz,
    source   => $url,
  }

}
