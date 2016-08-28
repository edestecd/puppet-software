# alfred.pp
# Install Alfred 2 for OS X, Ubuntu, or Windows
# http://www.alfredapp.com
#
# Ubuntu gets an alternative:
# https://github.com/qdore/Mutate
# https://github.com/ManuelSchneid3r/albert
#

class software::utilities::alfred (
  $ensure            = $software::params::software_ensure,
  $applications_path = $software::params::applications_path,
  $utilities_path    = $software::params::utilities_path,
  $version           = $software::params::alfred_version,
  $url               = $software::params::alfred_url,
) inherits software::params {

  validate_string($ensure)

  case $::operatingsystem {
    'Darwin': {
      validate_absolute_path($applications_path)
      validate_absolute_path($utilities_path)
      validate_string($version)
      validate_string($url)

      $app       = 'Alfred 3.app'
      $app_path  = "${applications_path}/${app}"
      $util_path = "${utilities_path}/${app}"

      package { "Alfred-${version}":
        ensure   => $ensure,
        provider => appcompressed,
        source   => $url,
      } ->

      # Move to /Applications/Utilities/
      exec { "Alfred-${version}->Utilities":
        command => "rm -rf '${util_path}' && mv '${app_path}' '${util_path}'",
        onlyif  => "test -e '${app_path}'",
        path    => ['/bin', '/usr/bin', '/sbin', '/usr/sbin', '/usr/local/bin', '/usr/local/sbin'],
      }
    }
    'Ubuntu': {
      $apt_ppa_ensure = $ensure ? {
        'installed' => present,
        'latest'    => present,
        default     => $ensure,
      }

      include '::apt'
      apt::ppa { 'ppa:mutate/ppa':
        ensure         => $apt_ppa_ensure,
        package_manage => true,
      } -> Class['apt::update'] ->

      package { 'mutate':
        ensure => $ensure,
      }
    }
    'windows': {
      package { 'wox':
        ensure   => $ensure,
        provider => chocolatey,
      }
    }
    default: {
      fail("The ${name} class is not supported on ${::operatingsystem}.")
    }
  }

}
