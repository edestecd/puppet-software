# anvil.pp
# Install Anvil for osx
# http://anvilformac.com
#

class software::webstack::anvil (
  $applications_path = $software::params::applications_path,
  $url               = $software::params::anvil_url,
) inherits software::params {

  validate_absolute_path($applications_path)
  validate_string($url)

  $app      = 'Anvil.app'
  $app_path = file_join($applications_path, $app)

  package { 'Anvil':
    ensure   => installed,
    provider => appcompressed,
    source   => $url,
  }

}
