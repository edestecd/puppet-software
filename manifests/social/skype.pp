# skype.pp
# Install Skype for osx
# http://www.skype.com/en
#

class software::social::skype (
  $applications_path = $software::params::applications_path,
  $version           = $software::params::skype_version,
  $url               = $software::params::skype_url,
) inherits software::params {

  validate_absolute_path($applications_path)
  validate_string($version)
  validate_string($url)

  $app      = 'Skype.app'
  $app_path = file_join($applications_path, $app)

  package { "Skype-${version}":
    ensure   => installed,
    provider => appdmg,
    source   => $url,
  }

}
