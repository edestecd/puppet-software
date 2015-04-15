# browsers.pp
#
# browsers group
# Mainly web browsers and plugins
#
#

class software::browsers (
  $applications_path = $software::params::applications_path,
  $chrome_url        = $software::params::chrome_url,
  $firefox_version   = $software::params::firefox_version,
  $firefox_url       = $software::params::firefox_url,
) inherits software::params {

  class { 'software::browsers::chrome':
    applications_path => $applications_path,
    url               => $chrome_url,
  }

  class { 'software::browsers::firefox':
    applications_path => $applications_path,
    version           => $firefox_version,
    url               => $firefox_url,
  }

}
