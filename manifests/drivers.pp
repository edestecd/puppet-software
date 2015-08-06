# drivers.pp
#
# drivers group
# Install printer etc. drivers
#
#

class software::drivers (
  $ensure                 = $software::params::software_ensure,
  $lanier_mpc5503_version = $software::params::lanier_mpc5503_version,
  $lanier_mpc5503_url     = $software::params::lanier_mpc5503_url,
) inherits software::params {

  class { '::software::drivers::lanier_mpc5503':
    ensure  => $ensure,
    version => $lanier_mpc5503_version,
    url     => $lanier_mpc5503_url,
  }

}
