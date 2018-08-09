# storage.pp
#
# storage group
# File Storage apps..
# FTP/SFTP and Cloud Storage
#
#

class software::storage (
  $ensure = $software::params::software_ensure,
) inherits software::params {

  class { '::software::storage::fetch':
    ensure => $ensure,
  }

  class { '::software::storage::filezilla':
    ensure => $ensure,
  }

}
