# params.pp
# Set up Software parameters defaults etc.
# For osx software
#

class software::params (
  $ensure = $::software_ensure,
) {

  # At least OSX 10.8 "Mountain Lion"
  if ($::operatingsystem == 'Darwin') and (versioncmp($::macosx_productversion, '10.8') >= 0) {
    #### init ####
    $software_ensure = $ensure ? {
      undef   => installed,
      default => $ensure,
    }
    $applications_path     = file_join('', 'Applications')
    $utilities_path        = file_join($applications_path, 'Utilities')
    $preference_panes_path = file_join('', 'Library', 'PreferencePanes')


    #### browsers ####
    $chrome_url      = 'https://dl.google.com/chrome/mac/stable/GGRO/googlechrome.dmg'
    $firefox_version = '36.0.1'
    $firefox_url     = "https://download-installer.cdn.mozilla.net/pub/firefox/releases/${firefox_version}/mac/en-US/Firefox%20${firefox_version}.dmg"


    #### database ####
    $pgcommander_version = '1.5.5'
    $pgcommander_url     = "https://eggerapps.at/pgcommander/download/pgcommander-${pgcommander_version}.zip"
    $sequelpro_version   = '1.0.2'
    $sequelpro_url       = "https://sequel-pro.googlecode.com/files/sequel-pro-${sequelpro_version}.dmg"


    #### drivers ####
    $lanier_mpc5503_version = '2.2.0.0'
    $lanier_mpc5503_url     = "http://support.ricoh.com/bb/pub_e/dr_ut_e/0001269/0001269425/V2200/LANIER_PS_Printers_Vol3_EXP_LIO_${lanier_mpc5503_version}.dmg"


    #### editors ####
    $sourcetree_version   = '2.0.5.2'
    $sourcetree_url       = "https://downloads.atlassian.com/software/sourcetree/SourceTree_${sourcetree_version}.dmg"
    $textmate_url         = 'https://api.textmate.org/downloads/release'
    $textwrangler_version = '4.5.12'
    $textwrangler_url     = "https://s3.amazonaws.com/BBSW-download/TextWrangler_${textwrangler_version}.dmg"


    #### entertainment ####
    $vlc_version = '2.2.0'
    $vlc_url     = "https://get.videolan.org/vlc/${vlc_version}/macosx/vlc-${vlc_version}.dmg"


    #### idesdk ####
    $android_sdk_version    = '20140702'
    $android_sdk_url        = "https://dl.google.com/android/adt/adt-bundle-mac-x86_64-${android_sdk_version}.zip"
    $android_studio_version = '135.1339820'
    $android_studio_url     = "https://dl.google.com/android/studio/install/0.8.6/android-studio-bundle-${android_studio_version}-mac.dmg"


    #### prefpanes ####
    $hosts_version        = '1.3'
    $hosts_url            = "https://github.com/downloads/specialunderwear/Hosts.prefpane/Hosts-${hosts_version}.pkg"
    $launchrocket_version = '0.7'
    $launchrocket_url     = "https://github.com/jimbojsb/launchrocket/releases/download/v${launchrocket_version}/LaunchRocket.prefPane.zip"


    #### social ####
    $skype_version = '7.5.738'
    $skype_url     = "http://download.skype.com/macosx/36ef3be64252e5a4a2db5ba4aa6c0df3/Skype_${skype_version}.dmg"


    #### storage ####
    $drive_url     = 'https://dl.google.com/drive/installgoogledrive.dmg'
    $fetch_version = '5.7.5'
    $fetch_url     = "http://getfetch.com/Fetch_${fetch_version}.dmg"


    #### utilities ####
    $alfred_version       = '2.6_374'
    $alfred_url           = "https://cachefly.alfredapp.com/Alfred_${alfred_version}.zip"
    $controlplane_version = '1.5.6'
    $controlplane_url     = "https://dl.dropboxusercontent.com/u/12850/ControlPlane/ControlPlane-${controlplane_version}.dmg"
    $iterm_version        = '2_0'
    $iterm_url            = "https://iterm2.com/downloads/stable/iTerm2_v${iterm_version}.zip"


    #### virtualization ####
    $virtualbox_version = '4.3.24'
    $virtualbox_build   = '98716'
    $virtualbox_url     = "http://download.virtualbox.org/virtualbox/${virtualbox_version}/VirtualBox-${virtualbox_version}-${virtualbox_build}-OSX.dmg"


    #### webstack ####
    $anvil_url = 'http://s3.amazonaws.com/sparkler_versions/versions/uploads/000/000/114/original/Anvil.zip'
    $pow_url   = 'get.pow.cx'


    if versioncmp($::macosx_productversion_major, '10.8') == 0 {
      #### utilities ####
      $onyx_url = 'http://www.titanium.free.fr/download/108/OnyX.dmg'
    } elsif versioncmp($::macosx_productversion_major, '10.9') == 0 {
      #### utilities ####
      $onyx_url = 'http://joel.barriere.pagesperso-orange.fr/dl/109/OnyX.dmg'
    } elsif versioncmp($::macosx_productversion_major, '10.10') == 0 {
      #### utilities ####
      $onyx_url = 'http://joel.barriere.pagesperso-orange.fr/dl/1010/OnyX.dmg'
    } else {
      fail("The ${module_name} module only supports 'Mountain Lion', 'Mavericks', 'Yosemite‎'.")
    }
  } elsif ($::operatingsystem == 'Ubuntu') and (versioncmp($::operatingsystemrelease, '12.04') >= 0) {
    #### init ####
    $software_ensure = $ensure ? {
      undef   => latest,
      default => $ensure,
    }


    #### browsers ####
    $chrome_url = 'http://dl.google.com/linux/chrome/deb/'


  } else {
    fail("The ${module_name} module is not supported on ${::operatingsystem} with version ${::operatingsystemrelease}.")
  }

}
