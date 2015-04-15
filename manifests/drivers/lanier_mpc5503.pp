# lanier_mpc5503.pp
# Install Lanier MP C5503 drivers for osx
#
# Apple all in one:
#   http://support.apple.com/downloads/
# Lanier Site (specific to printer only):
#   http://www.lanier.com/downloads/Default.aspx?hbn=drivers
#

class software::drivers::lanier_mpc5503 (
  $version = $software::params::lanier_mpc5503_version,
  $url     = $software::params::lanier_mpc5503_url,
) inherits software::params {

  validate_string($version)
  validate_string($url)

  package { "Lanier-MPC5503-${version}":
    ensure   => installed,
    provider => pkgdmg,
    source   => $url,
  }

  printer { 'BIO-PBD009-mpc5503':
    ensure      => present,
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
    require     => Package["Lanier-MPC5503-${version}"],
  }

}
