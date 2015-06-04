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
    $firefox_version = '37.0.2'
    $firefox_url     = "https://download-installer.cdn.mozilla.net/pub/firefox/releases/${firefox_version}/mac/en-US/Firefox%20${firefox_version}.dmg"


    #### database ####
    $mysqlworkbench_version = '6.3.3'
    $mysqlworkbench_url     = "http://cdn.mysql.com/Downloads/MySQLGUITools/mysql-workbench-community-${mysqlworkbench_version}-osx-x86_64.dmg"
    $pgcommander_version    = '1.5.5'
    $pgcommander_url        = "https://eggerapps.at/pgcommander/download/pgcommander-${pgcommander_version}.zip"
    $sequelpro_version      = '1.0.2'
    $sequelpro_url          = "https://sequel-pro.googlecode.com/files/sequel-pro-${sequelpro_version}.dmg"


    #### drivers ####
    $lanier_mpc5503_version = '2.2.0.0'
    $lanier_mpc5503_url     = "http://support.ricoh.com/bb/pub_e/dr_ut_e/0001269/0001269425/V2200/LANIER_PS_Printers_Vol3_EXP_LIO_${lanier_mpc5503_version}.dmg"


    #### editors ####
    $atom_url             = 'https://atom.io/download/mac'
    $textmate_url         = 'https://api.textmate.org/downloads/release'
    $textwrangler_version = '4.5.12'
    $textwrangler_url     = "https://s3.amazonaws.com/BBSW-download/TextWrangler_${textwrangler_version}.dmg"


    #### entertainment ####
    $vlc_version = '2.2.1'
    $vlc_url     = "https://get.videolan.org/vlc/${vlc_version}/macosx/vlc-${vlc_version}.dmg"


    #### idesdk ####
    $android_studio_version = '135.1740770'
    $android_studio_url     = "https://dl.google.com/dl/android/studio/install/1.1.0/android-studio-ide-${android_studio_version}-mac.dmg"


    #### prefpanes ####
    $hosts_version        = '1.3'
    $hosts_url            = "https://github.com/downloads/specialunderwear/Hosts.prefpane/Hosts-${hosts_version}.pkg"
    $launchrocket_version = '0.7'
    $launchrocket_url     = "https://github.com/jimbojsb/launchrocket/releases/download/v${launchrocket_version}/LaunchRocket.prefPane.zip"


    #### social ####
    $skype_version = '7.7.335'
    $skype_url     = "http://download.skype.com/macosx/f7bfbd2489fd90e643c40ce418b05fc3/Skype_${skype_version}.dmg"


    #### storage ####
    $drive_url         = 'https://dl.google.com/drive/installgoogledrive.dmg'
    $fetch_version     = '5.7.5'
    $fetch_url         = "http://getfetch.com/Fetch_${fetch_version}.dmg"
    $filezilla_version = '3.10.3'
    $filezilla_url     = "https://sourceforge.net/projects/filezilla/files/FileZilla_Client/${filezilla_version}/FileZilla_${filezilla_version}_macosx-x86.app.tar.bz2/download"


    #### utilities ####
    $alfred_version       = '2.7.1_387'
    $alfred_url           = "https://cachefly.alfredapp.com/Alfred_${alfred_version}.zip"
    $controlplane_version = '1.5.7'
    $controlplane_url     = "https://dl.dropboxusercontent.com/u/12850/ControlPlane/ControlPlane-${controlplane_version}.dmg"
    $iterm_version        = '2_0'
    $iterm_url            = "https://iterm2.com/downloads/stable/iTerm2_v${iterm_version}.zip"


    #### vcsscm ####
    $sourcetree_version = '2.0.5.2'
    $sourcetree_url     = "https://downloads.atlassian.com/software/sourcetree/SourceTree_${sourcetree_version}.dmg"


    #### virtualization ####
    $virtualbox_version = '4.3.26'
    $virtualbox_build   = '98988'
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
    $chrome_url     = 'http://dl.google.com/linux/chrome/deb/'
    $chrome_channel = 'stable'


    #### editors ####
    $atom_url = 'https://atom.io/download/deb'


  } else {
    fail("The ${module_name} module is not supported on ${::operatingsystem} with version ${::operatingsystemrelease}.")
  }

}
