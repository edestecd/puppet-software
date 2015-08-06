# vcsscm.pp
#
# vcsscm group
# Version Control Systems
# Software Configuration Management
# Mainly repo editors/managers/visualizers for git and the like
#
#

class software::vcsscm (
  $ensure             = $software::params::software_ensure,
  $sourcetree_version = $software::params::sourcetree_version,
  $sourcetree_url     = $software::params::sourcetree_url,
) inherits software::params {

  class { '::software::vcsscm::sourcetree':
    ensure  => $ensure,
    version => $sourcetree_version,
    url     => $sourcetree_url,
  }

}
