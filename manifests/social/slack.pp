# slack.pp
# Install Slack for OS X, Ubuntu, or Windows
# https://www.slack.com
#

class software::social::slack (
  $ensure  = $software::params::software_ensure,
) inherits software::params {

  validate_string($ensure)

  case $::operatingsystem {
    'Ubuntu': {
      # from https://packagecloud.io/slacktechnologies/slack/install#puppet
      include '::apt'
      include packagecloud

      packagecloud::repo { 'slacktechnologies/slack':
        type => 'deb',
      } -> Class['apt::update'] ->

      package { 'slack-desktop':
        ensure => $ensure,
      }
    }
    default: {
      fail("The ${name} class is not supported on ${::operatingsystem}.")
    }
  }

}
