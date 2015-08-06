# storage.pp
#
# storage group
# File Storage apps..
# FTP/SFTP and Cloud Storage
#
#

class software::storage (
  $ensure            = $software::params::software_ensure,
  $drive_url         = $software::params::drive_url,
  $fetch_version     = $software::params::fetch_version,
  $fetch_url         = $software::params::fetch_url,
  $filezilla_version = $software::params::filezilla_version,
  $filezilla_url     = $software::params::filezilla_url,
) inherits software::params {

  class { '::software::storage::drive':
    ensure => $ensure,
    url    => $drive_url,
  }

  class { '::software::storage::fetch':
    ensure  => $ensure,
    version => $fetch_version,
    url     => $fetch_url,
  }

  class { '::software::storage::filezilla':
    ensure  => $ensure,
    version => $filezilla_version,
    url     => $filezilla_url,
  }

}
