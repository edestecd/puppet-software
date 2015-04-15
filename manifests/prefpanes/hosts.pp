# hosts.pp
# Install specialunderwear/Hosts.prefpane for osx
# https://github.com/specialunderwear/Hosts.prefpane
#

class software::prefpanes::hosts (
  $preference_panes_path = $software::params::preference_panes_path,
  $version               = $software::params::hosts_version,
  $url                   = $software::params::hosts_url,
) inherits software::params {

  validate_absolute_path($preference_panes_path)
  validate_string($version)
  validate_string($url)

  $pane      = 'Hosts.prefPane'
  $pane_path = file_join($preference_panes_path, $pane)

  package { "Hosts-${version}":
    ensure   => installed,
    provider => pkgdmg,
    source   => $url,
  }

}
