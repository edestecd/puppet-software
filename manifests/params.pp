# params.pp
# Set up Software parameters defaults etc.
# For osx software
#

class software::params (
  $ensure = getvar('::software-ensure'),
  Boolean $manage_homebrew   = false,
  Boolean $manage_chocolatey = true,
) {

  # At least OSX 10.8 "Mountain Lion"
  if ($::operatingsystem == 'Darwin') and (versioncmp($::macosx_productversion, '10.8') >= 0) {
    # ### init ####
    $software_ensure = $ensure ? {
      undef   => installed,
      default => $ensure,
    }
    if $manage_homebrew { include '::homebrew' }
    $applications_path     = '/Applications'
    $utilities_path        = "${applications_path}/Utilities"
    $preference_panes_path = '/Library/PreferencePanes'


    # ### browsers ####
    $chrome_url     = undef
    $chrome_channel = undef


    # ### vcsscm ####
    $sourcetree_version = '2.4e'
    $sourcetree_url     = "https://downloads.atlassian.com/software/sourcetree/SourceTree_${sourcetree_version}.zip"


    # ### virtualization ####
    $virtualbox_version = '5.1.12'
    $virtualbox_build   = '112440'
    $virtualbox_url     = "http://download.virtualbox.org/virtualbox/${virtualbox_version}/VirtualBox-${virtualbox_version}-${virtualbox_build}-OSX.dmg"
    $virtualbox_key     = undef


    # ### webstack ####
    $anvil_url = 'http://s3.amazonaws.com/sparkler_versions/versions/uploads/000/000/129/original/Anvil_2016-02-24_11-50-56.zip'
    $pow_url   = 'get.pow.cx'
  } elsif (
    ($::operatingsystem == 'Debian') and (versioncmp($::operatingsystemrelease, '7') >= 0) or
    ($::operatingsystem == 'Ubuntu') and (versioncmp($::operatingsystemrelease, '12.04') >= 0)
  ) {
    # ### init ####
    $software_ensure = $ensure ? {
      undef   => latest,
      default => $ensure,
    }


    # ### browsers ####
    $chrome_url     = 'http://dl.google.com/linux/chrome/deb/'
    $chrome_channel = 'stable'


    # ### virtualization ####
    $virtualbox_version = '5.1'
    $virtualbox_build   = '112440'
    $virtualbox_url     = 'http://download.virtualbox.org/virtualbox/debian'
    if versioncmp($::operatingsystemrelease, '16.04') >= 0 {
      $virtualbox_key = {
        'id'     => 'B9F8D658297AF3EFC18D5CDFA2F683C52980AECF',
        'source' => 'https://www.virtualbox.org/download/oracle_vbox_2016.asc',
      }
    } else {
      $virtualbox_key = {
        'id'     => '7B0FAB3A13B907435925D9C954422A4B98AB5139',
        'source' => 'https://www.virtualbox.org/download/oracle_vbox.asc',
      }
    }
  } elsif ($::operatingsystem == 'windows') and (versioncmp($::operatingsystemrelease, '7') >= 0) {
    # ### init ####
    $software_ensure = $ensure ? {
      undef   => latest,
      default => $ensure,
    }
    if $manage_chocolatey { include '::chocolatey' }


    # ### browsers ####
    $chrome_url     = undef
    $chrome_channel = undef


    # ### virtualization ####
    $virtualbox_version = undef
    $virtualbox_build   = undef
    $virtualbox_url     = undef
    $virtualbox_key     = undef
  } else {
    fail("The ${module_name} module is not supported on ${::operatingsystem} with version ${::operatingsystemrelease}.")
  }

}
