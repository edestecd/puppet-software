# prefpanes.pp
#
# prefpanes group
# Add System Preferences Preference Panes
#
#

class software::prefpanes (
  $preference_panes_path = $software::params::preference_panes_path,
  $hosts_version         = $software::params::hosts_version,
  $hosts_url             = $software::params::hosts_url,
  $launchrocket_version  = $software::params::launchrocket_version,
  $launchrocket_url      = $software::params::launchrocket_url,
) inherits software::params {

  class { 'software::prefpanes::hosts':
    preference_panes_path => $preference_panes_path,
    version               => $hosts_version,
    url                   => $hosts_url,
  }

  class { 'software::prefpanes::launchrocket':
    preference_panes_path => $preference_panes_path,
    version               => $launchrocket_version,
    url                   => $launchrocket_url,
  }

}
