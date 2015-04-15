# database.pp
#
# database group
# Mainly graphical database editors for MySQL and PostgreSQL
#
#

class software::database (
  $applications_path   = $software::params::applications_path,
  $sequelpro_version   = $software::params::sequelpro_version,
  $sequelpro_url       = $software::params::sequelpro_url,
  $pgcommander_version = $software::params::pgcommander_version,
  $pgcommander_url     = $software::params::pgcommander_url,
) inherits software::params {

  class { 'software::database::sequelpro':
    applications_path => $applications_path,
    version           => $sequelpro_version,
    url               => $sequelpro_url,
  }

  class { 'software::database::pgcommander':
    applications_path => $applications_path,
    version           => $pgcommander_version,
    url               => $pgcommander_url,
  }

}
