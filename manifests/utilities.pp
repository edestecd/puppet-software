# utilities.pp
#
# utilities group
# Items that go in: /Applications/Utilities/
#
#

class software::utilities (
  $applications_path    = $software::params::applications_path,
  $utilities_path       = $software::params::utilities_path,
  $iterm_version        = $software::params::iterm_version,
  $iterm_url            = $software::params::iterm_url,
  $onyx_url             = $software::params::onyx_url,
  $controlplane_version = $software::params::controlplane_version,
  $controlplane_url     = $software::params::controlplane_url,
  $alfred_version       = $software::params::alfred_version,
  $alfred_url           = $software::params::alfred_url,
) inherits software::params {

  class { 'software::utilities::iterm':
    applications_path => $applications_path,
    utilities_path    => $utilities_path,
    version           => $iterm_version,
    url               => $iterm_url,
  }

  class { 'software::utilities::onyx':
    applications_path => $applications_path,
    utilities_path    => $utilities_path,
    url               => $onyx_url,
  }

  class { 'software::utilities::controlplane':
    applications_path => $applications_path,
    utilities_path    => $utilities_path,
    version           => $controlplane_version,
    url               => $controlplane_url,
  }

  class { 'software::utilities::alfred':
    applications_path => $applications_path,
    utilities_path    => $utilities_path,
    version           => $alfred_version,
    url               => $alfred_url,
  }

}
