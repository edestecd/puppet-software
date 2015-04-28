# editors.pp
#
# editors group
# Mainly text editors
#
#

class software::editors (
  $ensure               = $software::params::software_ensure,
  $textmate_url         = $software::params::textmate_url,
  $textwrangler_version = $software::params::textwrangler_version,
  $textwrangler_url     = $software::params::textwrangler_url,
) inherits software::params {

  class { 'software::editors::textmate':
    ensure => $ensure,
    url    => $textmate_url,
  }

  class { 'software::editors::textwrangler':
    ensure  => $ensure,
    version => $textwrangler_version,
    url     => $textwrangler_url,
  }

}
