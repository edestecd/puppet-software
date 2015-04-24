# database.pp
#
# database group
# Mainly graphical database editors for MySQL and PostgreSQL
#
#

class software::database (
  $ensure              = $software::params::software_ensure,
  $pgcommander_version = $software::params::pgcommander_version,
  $pgcommander_url     = $software::params::pgcommander_url,
  $sequelpro_version   = $software::params::sequelpro_version,
  $sequelpro_url       = $software::params::sequelpro_url,
) inherits software::params {

  class { 'software::database::pgcommander':
    ensure  => $ensure,
    version => $pgcommander_version,
    url     => $pgcommander_url,
  }

  class { 'software::database::sequelpro':
    ensure  => $ensure,
    version => $sequelpro_version,
    url     => $sequelpro_url,
  }

}
