# vim.pp
# Install VI Improved
#

class software::editors::vim (
  $ensure = $software::params::software_ensure,
) inherits software::params {

  $provider = $facts['os']['name'] ? {
    /(Debian|Ubuntu)/ => undef,
    'windows'         => chocolatey,
    default           => fail("The ${name} class is not supported on ${facts['os']['name']}."),
  }

  package { 'vim':
    ensure   => $ensure,
    provider => $provider,
  }
}
