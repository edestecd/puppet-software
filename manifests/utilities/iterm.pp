# iterm.pp
# Install iTerm 2 for OS X
# http://www.iterm2.com
#

class software::utilities::iterm (
  $ensure            = $software::params::software_ensure,
  $applications_path = $software::params::applications_path,
  $utilities_path    = $software::params::utilities_path,
  $version           = $software::params::iterm_version,
  $url               = $software::params::iterm_url,
) inherits software::params {

  validate_string($ensure)

  case $::operatingsystem {
    'Darwin': {
      validate_absolute_path($applications_path)
      validate_absolute_path($utilities_path)
      validate_string($version)
      validate_string($url)

      $app       = 'iTerm.app'
      $app_path  = "${applications_path}/${app}"
      $util_path = "${utilities_path}/${app}"

      package { "iTerm-${version}":
        ensure   => $ensure,
        provider => appcompressed,
        source   => $url,
      } ->

      # Move to /Applications/Utilities/
      exec { "iTerm-${version}->Utilities":
        command => "rm -rf '${util_path}' && mv '${app_path}' '${util_path}'",
        onlyif  => "test -e '${app_path}'",
        path    => ['/bin', '/usr/bin', '/sbin', '/usr/sbin', '/usr/local/bin', '/usr/local/sbin'],
      }
    }
    default: {
      fail("The ${name} class is not supported on ${::operatingsystem}.")
    }
  }

}
