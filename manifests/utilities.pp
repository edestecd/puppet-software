# utilities.pp
#
# utilities group
#
#

class software::utilities (
  $ensure = $software::params::software_ensure,
) inherits software::params {

  class { '::software::utilities::controlplane':
    ensure => $ensure,
  }

  class { '::software::utilities::iterm':
    ensure => $ensure,
  }

  class { '::software::utilities::onyx':
    ensure => $ensure,
  }

}
