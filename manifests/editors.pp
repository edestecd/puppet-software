# editors.pp
#
# editors group
# Mainly text editors and repo editors
#
#

class software::editors (
  $applications_path    = $software::params::applications_path,
  $sourcetree_version   = $software::params::sourcetree_version,
  $sourcetree_url       = $software::params::sourcetree_url,
  $textmate_url         = $software::params::textmate_url,
  $textwrangler_version = $software::params::textwrangler_version,
  $textwrangler_url     = $software::params::textwrangler_url,
) inherits software::params {

  class { 'software::editors::sourcetree':
    applications_path => $applications_path,
    version           => $sourcetree_version,
    url               => $sourcetree_url,
  }

  class { 'software::editors::textmate':
    applications_path => $applications_path,
    url               => $textmate_url,
  }

  class { 'software::editors::textwrangler':
    applications_path => $applications_path,
    version           => $textwrangler_version,
    url               => $textwrangler_url,
  }

}
