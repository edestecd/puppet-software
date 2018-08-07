# atom.pp
# Install Atom, GitHub's text editor
# https://atom.io
#
# Gets the latest release version...
#

class software::editors::atom (
  $ensure        = $software::params::software_ensure,
  Hash $packages = {},
  Hash $themes   = {},
  $user          = undef,
) inherits software::params {

  unless empty(merge($packages, $themes)) {
    assert_type(String[1], $user)
  }

  case $facts['os']['name'] {
    'Darwin': {
      $apm_require = File['/usr/local/bin/apm']

      package { 'atom':
        ensure   => $ensure,
        provider => brewcask,
      }

      file { '/usr/local/bin/apm':
        ensure  => link,
        target  => '/Applications/Atom.app/Contents/Resources/app/apm/node_modules/.bin/apm',
        mode    => '0755',
        require => Package['atom'],
      }

      -> file { '/usr/local/bin/atom':
        ensure  => link,
        target  => '/Applications/Atom.app/Contents/Resources/app/atom.sh',
        mode    => '0755',
        require => Package['atom'],
      }
    }
    'Debian': {
      $apm_require = Package['atom']

      package { 'atom':
        ensure   => $ensure,
        source   => '/tmp/atom-amd64.deb',
        provider => 'dpkg',
      }

      file { '/tmp/atom-amd64.deb':
        source => 'https://atom.io/download/deb',
        owner  => 'root',
        group  => 'root',
        mode   => '0644',
        before => Package['atom'],
      }
    }
    'Ubuntu': {
      $apm_require = Package['atom']
      $apt_ppa_ensure = $ensure ? {
        'installed' => present,
        'latest'    => present,
        default     => $ensure,
      }

      include '::apt'
      apt::ppa { 'ppa:webupd8team/atom':
        ensure         => $apt_ppa_ensure,
        package_manage => true,
      }
      -> Class['apt::update']

      -> package { 'atom':
        ensure => $ensure,
      }
    }
    'windows': {
      $apm_require = undef

      package { 'atom':
        ensure   => $ensure,
        provider => chocolatey,
      }
    }
    default: {
      fail("The ${name} class is not supported on ${facts['os']['name']}.")
    }
  }

  $apm_ensure = $ensure ? {
    'installed' => latest,
    default     => $ensure,
  }

  create_resources('package', merge($packages, $themes), {
      ensure   => $apm_ensure,
      provider => apm,
      source   => $user,
      require  => $apm_require,
  })

}
