# vlc.pp
# Install VideoLAN Media Player
# http://www.videolan.org/vlc/index.html
#

class software::entertainment::vlc (
  $ensure = $software::params::software_ensure,
) inherits software::params {

  $provider = $facts['os']['name'] ? {
    'Darwin'          => brewcask,
    /(Debian|Ubuntu)/ => undef,
    'windows'         => chocolatey,
    default           => fail("The ${name} class is not supported on ${facts['os']['name']}."),
  }

  package { 'vlc':
    ensure   => $ensure,
    provider => $provider,
  }
}
