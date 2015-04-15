# launchrocket.pp
# Install jimbojsb/launchrocket for osx
# https://github.com/jimbojsb/launchrocket
#

class software::prefpanes::launchrocket (
  $preference_panes_path = $software::params::preference_panes_path,
  $version               = $software::params::launchrocket_version,
  $url                   = $software::params::launchrocket_url,
) inherits software::params {

  validate_absolute_path($preference_panes_path)
  validate_string($version)
  validate_string($url)

  $pane      = 'LaunchRocket.prefPane'
  $pane_path = file_join($preference_panes_path, $pane)

  package { "LaunchRocket-${version}":
    ensure   => installed,
    provider => prefpanecompressed,
    source   => $url,
  }

}
