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
  $applications_path = $software::params::applications_path,
  $vlc_version       = $software::params::vlc_version,
  $vlc_url           = $software::params::vlc_url,
) inherits software::params {

  class { 'software::entertainment::vlc':
    applications_path => $applications_path,
    version           => $vlc_version,
    url               => $vlc_url,
  }

}
