# storage.pp
#
# storage group
# File Storage apps..
# FTP/SFTP and Cloud Storage
#
#

class software::storage (
  $applications_path = $software::params::applications_path,
  $fetch_version     = $software::params::fetch_version,
  $fetch_url         = $software::params::fetch_url,
  $drive_url         = $software::params::drive_url,
) inherits software::params {

  class { 'software::storage::fetch':
    applications_path => $applications_path,
    version           => $fetch_version,
    url               => $fetch_url,
  }

  class { 'software::storage::drive':
    applications_path => $applications_path,
    url               => $drive_url,
  }

}
