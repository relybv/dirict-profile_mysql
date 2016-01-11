# == Class profile_mysql::install
#
# This class is called from profile_mysql for install.
#
class profile_mysql::install {

  package { $::profile_mysql::package_name:
    ensure => present,
  }
}
