# social.pp
#
# social group
# Chat/Messaging
#
#

class software::social (
  $applications_path = $software::params::applications_path,
  $skype_version     = $software::params::skype_version,
  $skype_url         = $software::params::skype_url,
) inherits software::params {

  class { 'software::social::skype':
    applications_path => $applications_path,
    version           => $skype_version,
    url               => $skype_url,
  }

}
