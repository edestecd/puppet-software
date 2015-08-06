# database.pp
#
# database group
# Mainly graphical database editors for MySQL and PostgreSQL
#
#

class software::database (
  $ensure                 = $software::params::software_ensure,
  $mysqlworkbench_version = $software::params::mysqlworkbench_version,
  $mysqlworkbench_url     = $software::params::mysqlworkbench_url,
  $pgcommander_version    = $software::params::pgcommander_version,
  $pgcommander_url        = $software::params::pgcommander_url,
  $sequelpro_version      = $software::params::sequelpro_version,
  $sequelpro_url          = $software::params::sequelpro_url,
) inherits software::params {

  class { '::software::database::mysqlworkbench':
    ensure  => $ensure,
    version => $mysqlworkbench_version,
    url     => $mysqlworkbench_url,
  }

  class { '::software::database::pgcommander':
    ensure  => $ensure,
    version => $pgcommander_version,
    url     => $pgcommander_url,
  }

  class { '::software::database::sequelpro':
    ensure  => $ensure,
    version => $sequelpro_version,
    url     => $sequelpro_url,
  }

}
