# database.pp
#
# database group
# Mainly graphical database editors for MySQL and PostgreSQL
#
#

class software::database (
  $ensure = $software::params::software_ensure,
) inherits software::params {

  class { '::software::database::mysqlworkbench':
    ensure => $ensure,
  }

  class { '::software::database::pgcommander':
    ensure => $ensure,
  }

  class { '::software::database::sequelpro':
    ensure => $ensure,
  }

}
