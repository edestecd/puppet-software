# mysqlworkbench.pp
# Install MySQL Workbench for OS X, Ubuntu, or Windows
# https://www.mysql.com/products/workbench
# https://dev.mysql.com/downloads/workbench
#

class software::database::mysqlworkbench (
  $ensure  = $software::params::software_ensure,
  $version = $software::params::mysqlworkbench_version,
  $url     = $software::params::mysqlworkbench_url,
) inherits software::params {

  validate_string($ensure)

  case $::operatingsystem {
    'Darwin': {
      validate_string($version)
      validate_string($url)

      package { "MySQLWorkbench-${version}":
        ensure   => $ensure,
        provider => appdmg,
        source   => $url,
      }
    }
    'Ubuntu': {
      package { 'mysql-workbench':
        ensure => $ensure,
      }
    }
    'windows': {
      package { 'mysql.workbench':
        ensure          => $ensure,
        provider        => chocolatey,
        install_options => ['--allow-empty-checksums'],
      }
    }
    default: {
      fail("The ${name} class is not supported on ${::operatingsystem}.")
    }
  }

}
