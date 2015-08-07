# onyx.pp
# Install OnyX for OS X
# http://www.titanium.free.fr
#

class software::utilities::onyx (
  $ensure            = $software::params::software_ensure,
  $applications_path = $software::params::applications_path,
  $utilities_path    = $software::params::utilities_path,
  $url               = $software::params::onyx_url,
) inherits software::params {

  validate_string($ensure)

  case $::operatingsystem {
    'Darwin': {
      validate_absolute_path($applications_path)
      validate_absolute_path($utilities_path)
      # validate_string($url)

      $app       = 'OnyX.app'
      $app_path  = "${applications_path}/${app}"
      $util_path = "${utilities_path}/${app}"

      if $url {
        package { "OnyX-${::macosx_productversion_major}":
          ensure   => $ensure,
          provider => appdmg,
          source   => $url,
        } ->

        # Move to /Applications/Utilities/
        exec { "OnyX-${::macosx_productversion_major}->Utilities":
          command => "rm -rf '${util_path}' && mv '${app_path}' '${util_path}'",
          onlyif  => "test -e '${app_path}'",
          path    => ['/bin', '/usr/bin', '/sbin', '/usr/sbin', '/usr/local/bin', '/usr/local/sbin'],
        }
      } else {
        notify { "No version of OnyX for OS X ${::macosx_productversion_major} yet. It will be added when available...": }
      }
    }
    default: {
      fail("The ${name} class is not supported on ${::operatingsystem}.")
    }
  }

}
