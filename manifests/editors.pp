# editors.pp
#
# editors group
# Mainly text editors
#
#

class software::editors (
  $ensure               = $software::params::software_ensure,
  $atom_url             = $software::params::atom_url,
  $textmate_url         = $software::params::textmate_url,
  $textwrangler_version = $software::params::textwrangler_version,
  $textwrangler_url     = $software::params::textwrangler_url,
) inherits software::params {

  class { '::software::editors::atom':
    ensure => $ensure,
    url    => $atom_url,
  }

  class { '::software::editors::textmate':
    ensure => $ensure,
    url    => $textmate_url,
  }

  class { '::software::editors::textwrangler':
    ensure  => $ensure,
    version => $textwrangler_version,
    url     => $textwrangler_url,
  }

  class { '::software::editors::vim':
    ensure => $ensure,
  }

}
