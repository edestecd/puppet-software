# textwrangler.pp
# Install TextWrangler for osx
# http://www.barebones.com/products/textwrangler
#

class software::editors::textwrangler (
  $applications_path = $software::params::applications_path,
  $version           = $software::params::textwrangler_version,
  $url               = $software::params::textwrangler_url,
) inherits software::params {

  validate_absolute_path($applications_path)
  validate_string($version)
  validate_string($url)

  $app      = 'TextWrangler.app'
  $app_path = file_join($applications_path, $app)

  package { "TextWrangler-${version}":
    ensure   => installed,
    provider => appdmg,
    source   => $url,
  }

}
