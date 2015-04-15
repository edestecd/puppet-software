# alfred.pp
# Install Alfred 2 for osx
# http://www.alfredapp.com
#

class software::utilities::alfred (
  $applications_path = $software::params::applications_path,
  $utilities_path    = $software::params::utilities_path,
  $version           = $software::params::alfred_version,
  $url               = $software::params::alfred_url,
) inherits software::params {

  validate_absolute_path($applications_path)
  validate_absolute_path($utilities_path)
  validate_string($version)
  validate_string($url)

  $app       = 'Alfred 2.app'
  $app_path  = file_join($applications_path, $app)
  $util_path = file_join($utilities_path, $app)

  package { "Alfred-${version}":
    ensure   => installed,
    provider => appcompressed,
    source   => $url,
  }

  # Move to /Applications/Utilities/
  exec { "Alfred-${version}->Utilities":
    command => "rm -rf '${util_path}' && mv '${app_path}' '${util_path}'",
    onlyif  => "test -e '${app_path}'",
    path    => ['/bin', '/usr/bin', '/sbin', '/usr/sbin', '/usr/local/bin', '/usr/local/sbin'],
    require => Package["Alfred-${version}"],
  }

}
