# webstack.pp
#
# webstack group
# Mainly:
#   Servers to run web apps locally on Mac
#   Zero config Rack server for rails/php apps
#
#

class software::webstack (
  $ensure = $software::params::software_ensure,
) inherits software::params {

  class { '::software::webstack::anvil':
    ensure => $ensure,
  }

}
