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
  $ensure = $software::params::software_ensure,
) inherits software::params {

  class { '::software::entertainment::vlc':
    ensure => $ensure,
  }

}
