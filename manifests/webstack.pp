# webstack.pp
#
# webstack group
# Mainly:
#   Servers to run web apps locally on Mac
#   Zero config Rack server for rails/php apps
#
#

class software::webstack (
  $ensure    = $software::params::software_ensure,
  $pow_url   = $software::params::pow_url,
  $anvil_url = $software::params::anvil_url,
) inherits software::params {

  # class { 'software::webstack::pow':
  #   ensure => $ensure,
  #   url    => $pow_url,
  # }

  class { '::software::webstack::anvil':
    ensure => $ensure,
    url    => $anvil_url,
  }

}
