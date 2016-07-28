# == Class profile_mysql::config
#
# This class is called from profile_mysql for service config.
#
class profile_mysql::config {
  # prevent direct use of subclass
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  mysql::db { $::profile_mysql::dbname:
    user     => $::profile_mysql::dbuser,
    password => $::profile_mysql::dbpassword,
    host     => '%',
    grant    => $::profile_mysql::dbgrant,
  }

}
