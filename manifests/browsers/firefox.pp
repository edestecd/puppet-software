# firefox.pp
# Install Firefox for OS X, Ubuntu, or Windows
# http://www.mozilla.org/en-US/firefox/new
#

class software::browsers::firefox (
  $ensure = $software::params::software_ensure,
) inherits software::params {

  $provider = $facts['os']['name'] ? {
    'Darwin'          => brewcask,
    /(Debian|Ubuntu)/ => undef,
    'windows'         => chocolatey,
    default           => fail("The ${name} class is not supported on ${facts['os']['name']}."),
  }

  package { 'firefox':
    ensure   => $ensure,
    provider => $provider,
  }
}
