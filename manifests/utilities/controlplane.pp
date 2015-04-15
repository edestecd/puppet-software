# controlplane.pp
# Install ControlPlane for osx
# http://www.controlplaneapp.com
#

class software::utilities::controlplane (
  $applications_path = $software::params::applications_path,
  $utilities_path    = $software::params::utilities_path,
  $version           = $software::params::controlplane_version,
  $url               = $software::params::controlplane_url,
) inherits software::params {

  validate_absolute_path($applications_path)
  validate_absolute_path($utilities_path)
  validate_string($version)
  validate_string($url)

  $app       = 'ControlPlane.app'
  $app_path  = file_join($applications_path, $app)
  $util_path = file_join($utilities_path, $app)

  package { "ControlPlane-${version}":
    ensure   => installed,
    provider => appdmg,
    source   => $url,
  }

  # Move to /Applications/Utilities/
  exec { "ControlPlane-${version}->Utilities":
    command => "rm -rf '${util_path}' && mv '${app_path}' '${util_path}'",
    onlyif  => "test -e '${app_path}'",
    path    => ['/bin', '/usr/bin', '/sbin', '/usr/sbin', '/usr/local/bin', '/usr/local/sbin'],
    require => Package["ControlPlane-${version}"],
  }

}
