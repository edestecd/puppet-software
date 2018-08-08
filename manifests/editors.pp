# editors.pp
#
# editors group
# Mainly text editors
#
#

class software::editors (
  $ensure = $software::params::software_ensure,
) inherits software::params {

  class { '::software::editors::atom':
    ensure => $ensure,
  }

  class { '::software::editors::textmate':
    ensure => $ensure,
  }

  class { '::software::editors::vim':
    ensure => $ensure,
  }

}
