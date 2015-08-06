# prefpanes.pp
#
# prefpanes group
# Add System Preferences Preference Panes
#
#

class software::prefpanes (
  $ensure               = $software::params::software_ensure,
  $hosts_version        = $software::params::hosts_version,
  $hosts_url            = $software::params::hosts_url,
  $launchrocket_version = $software::params::launchrocket_version,
  $launchrocket_url     = $software::params::launchrocket_url,
) inherits software::params {

  class { '::software::prefpanes::hosts':
    ensure  => $ensure,
    version => $hosts_version,
    url     => $hosts_url,
  }

  class { '::software::prefpanes::launchrocket':
    ensure  => $ensure,
    version => $launchrocket_version,
    url     => $launchrocket_url,
  }

}
