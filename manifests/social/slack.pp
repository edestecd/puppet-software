# slack.pp
# Install Slack for OS X, Ubuntu, or Windows
# https://www.slack.com, https://packagecloud.io/slacktechnologies
#

class software::social::slack (
  $ensure = $software::params::software_ensure,
) inherits software::params {

  validate_string($ensure)

  case $::operatingsystem {
    'Ubuntu': {
      $apt_source_ensure = $ensure ? {
        'installed' => present,
        'latest'    => present,
        default     => $ensure,
      }

      include '::apt'
      apt::source { 'slack':
        ensure   => $apt_source_ensure,
        comment  => 'Slack APT sources for any Debian-based distribution, including Ubuntu',
        location => 'https://packagecloud.io/slacktechnologies/slack/debian',
        release  => 'jessie',
        repos    => 'main',
        key      => {
          'id'     => 'C6ABDCF64DB9A0B2',
          'source' => 'https://packagecloud.io/slacktechnologies/slack/gpgkey',
        },
      }

      package { 'slack-desktop':
        ensure => $ensure,
      }
    }
    default: {
      fail("The ${name} class is not supported on ${::operatingsystem}.")
    }
  }

}
