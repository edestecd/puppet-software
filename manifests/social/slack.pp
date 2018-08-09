# slack.pp
# Install Slack for OS X, Ubuntu, or Windows
# https://www.slack.com, https://packagecloud.io/slacktechnologies
#

class software::social::slack (
  $ensure = $software::params::software_ensure,
) inherits software::params {

  case $facts['os']['name'] {
    'Darwin': {
      package { 'slack':
        ensure   => $ensure,
        provider => brewcask,
      }
    }
    'Debian', 'Ubuntu': {
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
          'id'     => 'DB085A08CA13B8ACB917E0F6D938EC0D038651BD',
          'source' => 'https://packagecloud.io/slacktechnologies/slack/gpgkey',
        },
      }
      -> Class['apt::update']

      -> package { 'slack-desktop':
        ensure => $ensure,
      }
    }
    'windows': {
      package { 'slack':
        ensure   => $ensure,
        provider => chocolatey,
      }
    }
    default: {
      fail("The ${name} class is not supported on ${facts['os']['name']}.")
    }
  }

}
