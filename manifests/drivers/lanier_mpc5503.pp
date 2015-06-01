# lanier_mpc5503.pp
# Install Lanier MP C5503 drivers for OS X
#
# Apple all in one:
#   http://support.apple.com/downloads/
# Lanier Site (specific to printer only):
#   http://www.lanier.com/downloads/Default.aspx?hbn=drivers
#

class software::drivers::lanier_mpc5503 (
  $ensure  = $software::params::software_ensure,
  $version = $software::params::lanier_mpc5503_version,
  $url     = $software::params::lanier_mpc5503_url,
) inherits software::params {

  validate_string($ensure)

  case $::operatingsystem {
    'Darwin': {
      validate_string($version)
      validate_string($url)

      $printer_ensure = $ensure ? {
        'installed' => present,
        default     => $ensure,
      }

      package { "Lanier-MPC5503-${version}":
        ensure   => $ensure,
        provider => pkgdmg,
        source   => $url,
      } ->

      printer { 'BIO-PBD009-mpc5503':
        ensure      => $printer_ensure,
        enabled     => true,
        uri         => 'smb://kepler.it.muohio.edu/BIO-PBD009-mpc5503',
        location    => 'PBD009',
        ppd         => '/Library/Printers/PPDs/Contents/Resources/LANIER MP C5503',
        shared      => false,
        #options     => { },
        ppd_options => {
          'OptionTray' => 'LCT',
          'Finisher'   => 'FinVOLGABBK',
        }, # *Finisher FinVOLGABBK/Finisher SR3170: ""
      }
    }
    default: {
      fail("The ${name} class is not supported on ${::operatingsystem}.")
    }
  }

}
