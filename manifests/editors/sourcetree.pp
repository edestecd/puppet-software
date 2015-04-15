# sourcetree.pp
# Install SourceTree for osx
# http://www.sourcetreeapp.com
#

class software::editors::sourcetree (
  $applications_path = $software::params::applications_path,
  $version           = $software::params::sourcetree_version,
  $url               = $software::params::sourcetree_url,
) inherits software::params {

  validate_absolute_path($applications_path)
  validate_string($version)
  validate_string($url)

  $app      = 'SourceTree.app'
  $app_path = file_join($applications_path, $app)

  package { "SourceTree-${version}":
    ensure   => installed,
    provider => appdmg,
    source   => $url,
  }

}
