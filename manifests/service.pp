# == Class profile_mysql::service
#
# This class is meant to be called from profile_mysql.
# It ensure the service is running.
#
class profile_mysql::service {
  # prevent direct use of subclass
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }
}
