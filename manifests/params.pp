# == Class profile_mysql::params
#
# This class is meant to be called from profile_mysql.
# It sets variables according to platform.
#
class profile_mysql::params {
  case $::osfamily {
    'Debian': {
      $package_name = 'profile_mysql'
      $service_name = 'profile_mysql'
    }
    'RedHat', 'Amazon': {
      $package_name = 'profile_mysql'
      $service_name = 'profile_mysql'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
