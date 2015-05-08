# atom.pp
# Install Atom, GitHub's text editor
# https://atom.io
#
# Gets the latest release version...
#

class software::editors::atom (
  $ensure   = $software::params::software_ensure,
  $url      = $software::params::atom_url,
  $packages = [],
  $themes   = [],
  $user     = undef,
) inherits software::params {

  validate_string($ensure)
  validate_string($url)
  validate_array($packages)
  validate_array($themes)

  unless empty(concat($packages, $themes)) {
    validate_string($user)
  }

  case $::operatingsystem {
    'Darwin': {
      $apm_require = File['/usr/local/bin/apm']

      package { 'Atom':
        ensure   => $ensure,
        provider => appcompressed,
        flavor   => zip,
        source   => $url,
      } ->

      file { '/usr/local/bin/apm':
        ensure => link,
        target => '/Applications/Atom.app/Contents/Resources/app/apm/node_modules/.bin/apm',
        mode   => '0755',
      } ->

      file { '/usr/local/bin/atom':
        ensure => link,
        target => '/Applications/Atom.app/Contents/Resources/app/atom.sh',
        mode   => '0755',
      }
    }
    'Ubuntu': {
      $apm_require = Package['atom']
      $apt_ppa_ensure = $ensure ? {
        installed => present,
        latest    => present,
        default   => $ensure,
      }

      include '::apt'
      apt::ppa { 'ppa:webupd8team/atom':
        ensure => $apt_ppa_ensure,
      } ->

      package { 'atom':
        ensure => $ensure,
      }
    }
    default: {
      fail("The ${name} class is not supported on ${::operatingsystem}.")
    }
  }

  $apm_ensure = $ensure ? { installed => latest, default => $ensure }
  ensure_resource('package', concat($packages, $themes), {
    ensure   => $apm_ensure,
    provider => apm,
    source   => $user,
    require  => $apm_require,
  })

}
