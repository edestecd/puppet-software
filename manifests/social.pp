# social.pp
#
# social group
# Chat/Messaging
#
#

class software::social (
  $ensure = $software::params::software_ensure,
) inherits software::params {

  class { '::software::social::skype':
    ensure => $ensure,
  }

  class { '::software::social::slack':
    ensure => $ensure,
  }

}
