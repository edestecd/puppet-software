# pgcommander.pp
# Install PG Commander for osx
# https://eggerapps.at/pgcommander
#

class software::database::pgcommander (
  $applications_path = $software::params::applications_path,
  $version           = $software::params::pgcommander_version,
  $url               = $software::params::pgcommander_url,
) inherits software::params {

  validate_absolute_path($applications_path)
  validate_string($version)
  validate_string($url)

  $app      = 'PG Commander.app'
  $app_path = file_join($applications_path, $app)

  package { "PGCommander-${version}":
    ensure   => installed,
    provider => appcompressed,
    source   => $url,
  }

}
