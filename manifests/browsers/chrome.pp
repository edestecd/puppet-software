# chrome.pp
# Install Google Chrome for OS X, Ubuntu, or Windows
# https://www.google.com/chrome/browser/desktop
# https://www.google.com/linuxrepositories
#

class software::browsers::chrome (
  $ensure  = $software::params::software_ensure,
  $url     = $software::params::chrome_url,
  $channel = $software::params::chrome_channel,
) inherits software::params {

  case $facts['os']['name'] {
    'Darwin': {
      package { 'google-chrome':
        ensure   => $ensure,
        provider => brewcask,
      }
    }
    'Debian', 'Ubuntu': {
      assert_type(Stdlib::HTTPUrl, $url)
      assert_type(String[1], $channel)

      $apt_source_ensure = $ensure ? {
        'installed' => present,
        'latest'    => present,
        default     => $ensure,
      }

      include '::apt'
      apt::source { 'google-chrome':
        ensure       => $apt_source_ensure,
        location     => $url,
        release      => 'stable',
        repos        => 'main',
        key          => {
          'id'     => '4CCA1EAF950CEE4AB83976DCA040830F7FAC5991',
          'source' => 'https://dl.google.com/linux/linux_signing_key.pub',
        },
        architecture => 'amd64',
      }
      -> Class['apt::update']

      -> package { "google-chrome-${channel}":
        ensure => $ensure,
      }
    }
    'windows': {
      package { 'googlechrome':
        ensure   => $ensure,
        provider => chocolatey,
      }
    }
    default: {
      fail("The ${name} class is not supported on ${facts['os']['name']}.")
    }
  }

}
