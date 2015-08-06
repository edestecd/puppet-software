# entertainment.pp
#
# entertainment group
# Mainly:
#   Video Players
#   Music Players
#   Games
#
#

class software::entertainment (
  $ensure      = $software::params::software_ensure,
  $vlc_version = $software::params::vlc_version,
  $vlc_url     = $software::params::vlc_url,
) inherits software::params {

  class { '::software::entertainment::vlc':
    ensure  => $ensure,
    version => $vlc_version,
    url     => $vlc_url,
  }

}
