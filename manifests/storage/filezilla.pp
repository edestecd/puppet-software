# filezilla.pp
# Install FileZilla for OS X, Ubuntu, or Windows
# https://filezilla-project.org
#

class software::storage::filezilla (
  $ensure  = $software::params::software_ensure,
  $version = $software::params::filezilla_version,
  $url     = $software::params::filezilla_url,
) inherits software::params {

  validate_string($ensure)

  case $::operatingsystem {
    'Darwin': {
      validate_string($version)
      validate_string($url)

      package { "FileZilla-${version}":
        ensure   => $ensure,
        provider => appcompressed,
        flavor   => tbz,
        source   => $url,
      }
    }
    'Ubuntu': {
      package { 'filezilla':
        ensure => $ensure,
      }
    }
    'windows': {
      package { 'filezilla':
        ensure   => $ensure,
        provider => chocolatey,
      }
    }
    default: {
      fail("The ${name} class is not supported on ${::operatingsystem}.")
    }
  }

}
