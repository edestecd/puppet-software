# prefpanes.pp
#
# prefpanes group
# Add System Preferences Preference Panes
#
#

class software::prefpanes (
  $ensure = $software::params::software_ensure,
) inherits software::params {

  class { '::software::prefpanes::launchrocket':
    ensure => $ensure,
  }

}
