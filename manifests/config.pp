# == Class profile_mysql::config
#
# This class is called from profile_mysql for service config.
#
class profile_mysql::config {
  # prevent direct use of subclass
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  mysql_user {"${::profile_mysql::dbuser}@%":
    ensure        => present,
    password_hash => mysql_password($::profile_mysql::dbpassword),
  }

  mysql_grant {"${::profile_mysql::dbuser}@%/*.*":
    ensure     => 'present',
    options    => ['GRANT'],
    privileges => $::profile_mysql::dbgrant,
    table      => '*.*',
    user       => "${::profile_mysql::dbuser}@%",
  }

  class {'::mysql::server::monitor':
    mysql_monitor_username => 'monitor',
    mysql_monitor_password => 'monitor',
    mysql_monitor_hostname => 'localhost',
  }
}
