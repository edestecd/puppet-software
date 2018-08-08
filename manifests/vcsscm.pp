# vcsscm.pp
#
# vcsscm group
# Version Control Systems
# Software Configuration Management
# Mainly repo editors/managers/visualizers for git and the like
#
#

class software::vcsscm (
  $ensure = $software::params::software_ensure,
) inherits software::params {

  class { '::software::vcsscm::sourcetree':
    ensure => $ensure,
  }

}
