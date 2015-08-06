# browsers.pp
#
# browsers group
# Mainly web browsers and plugins
#
#

class software::browsers (
  $ensure          = $software::params::software_ensure,
  $chrome_url      = $software::params::chrome_url,
  $chrome_channel  = $software::params::chrome_channel,
  $firefox_version = $software::params::firefox_version,
  $firefox_url     = $software::params::firefox_url,
) inherits software::params {

  class { '::software::browsers::chrome':
    ensure  => $ensure,
    url     => $chrome_url,
    channel => $chrome_channel,
  }

  class { '::software::browsers::firefox':
    ensure  => $ensure,
    version => $firefox_version,
    url     => $firefox_url,
  }

}
