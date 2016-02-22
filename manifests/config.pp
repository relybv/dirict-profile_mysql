# == Class profile_mysql::config
#
# This class is called from profile_mysql for service config.
#
class profile_mysql::config {

  mysql::db { $::profile_mysql::dbname:
    user     => $::profile_mysql::dbuser,
    password => $::profile_mysql::dbpassword,
    host     => 'localhost',
    grant    => $::profile_mysql::dbgrant,
  }

}
