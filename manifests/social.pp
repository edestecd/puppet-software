# social.pp
#
# social group
# Chat/Messaging
#
#

class software::social (
  $ensure        = $software::params::software_ensure,
  $skype_version = $software::params::skype_version,
  $skype_url     = $software::params::skype_url,
) inherits software::params {

  class { '::software::social::skype':
    ensure  => $ensure,
    version => $skype_version,
    url     => $skype_url,
  }

}
