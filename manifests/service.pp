# == Class profile_mysql::service
#
# This class is meant to be called from profile_mysql.
# It ensure the service is running.
#
class profile_mysql::service {

  service { $::profile_mysql::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
