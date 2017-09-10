# slack.pp
# Install Slack for OS X, Ubuntu, or Windows
# https://www.slack.com
#

class software::social::slack (
  $ensure  = $software::params::software_ensure,
  $version = $software::params::slack_version,
  $url     = $software::params::slack_url,
) inherits software::params {

  validate_string($ensure)

  case $::operatingsystem {
    'Ubuntu': {
      $package = "slack-desktop-${version}-${::architecture}.deb"

      archive { $package:
        source  => $url,
        path    => "/tmp/${package}",
        extract => false,
        cleanup => false,
      }

      package { 'slack-desktop':
        ensure   => $ensure,
        source   => "/tmp/${package}",
        provider => 'dpkg',
      }
    }
    default: {
      fail("The ${name} class is not supported on ${::operatingsystem}.")
    }
  }

}
