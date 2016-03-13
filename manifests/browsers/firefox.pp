# firefox.pp
# Install Firefox for OS X, Ubuntu, or Windows
# http://www.mozilla.org/en-US/firefox/new
#

class software::browsers::firefox (
  $ensure  = $software::params::software_ensure,
  $version = $software::params::firefox_version,
  $url     = $software::params::firefox_url,
) inherits software::params {

  validate_string($ensure)

  case $::operatingsystem {
    'Darwin': {
      validate_string($version)
      validate_string($url)

      package { "Firefox-${version}":
        ensure   => $ensure,
        provider => appdmg,
        source   => $url,
      }
    }
    'Ubuntu': {
      package { 'firefox':
        ensure => $ensure,
      }
    }
    'windows': {
      package { 'firefox':
        ensure   => $ensure,
        provider => chocolatey,
      }
    }
    default: {
      fail("The ${name} class is not supported on ${::operatingsystem}.")
    }
  }

}
