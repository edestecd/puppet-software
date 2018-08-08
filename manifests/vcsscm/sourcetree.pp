# sourcetree.pp
# Install SourceTree for OS X or Windows
# http://www.sourcetreeapp.com
#

class software::vcsscm::sourcetree (
  $ensure = $software::params::software_ensure,
) inherits software::params {

  $provider = $facts['os']['name'] ? {
    'Darwin'  => brewcask,
    'windows' => chocolatey,
    default   => fail("The ${name} class is not supported on ${facts['os']['name']}."),
  }

  package { 'sourcetree':
    ensure   => $ensure,
    provider => $provider,
  }
}
