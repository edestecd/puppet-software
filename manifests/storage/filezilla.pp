# filezilla.pp
# Install FileZilla for OS X, Ubuntu, or Windows
# https://filezilla-project.org
#

class software::storage::filezilla (
  $ensure = $software::params::software_ensure,
) inherits software::params {

  $provider = $facts['os']['name'] ? {
    'Darwin'          => brewcask,
    /(Debian|Ubuntu)/ => undef,
    'windows'         => chocolatey,
    default           => fail("The ${name} class is not supported on ${facts['os']['name']}."),
  }

  package { 'filezilla':
    ensure   => $ensure,
    provider => $provider,
  }
}
