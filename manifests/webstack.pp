# webstack.pp
#
# webstack group
# Mainly:
#   Servers to run web apps locally on Mac
#   Zero config Rack server for rails/php apps
#
#

class software::webstack (
  $applications_path = $software::params::applications_path,
  $pow_url           = $software::params::pow_url,
  $anvil_url         = $software::params::anvil_url,
) inherits software::params {

  # class { 'software::webstack::pow':
  #   applications_path => $applications_path,
  #   url               => $pow_url,
  # }

  class { 'software::webstack::anvil':
    applications_path => $applications_path,
    url               => $anvil_url,
  }

}
