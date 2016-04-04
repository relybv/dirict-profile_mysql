# == Class: profile_mysql
#
# Full description of class profile_mysql here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
#
class profile_mysql
(
  $dbname = $::profile_mysql::params::dbname,
  $dbuser = $::profile_mysql::params::dbuser,
  $dbpassword = $::profile_mysql::params::dbpassword,
  $dbgrant = $::profile_mysql::params::dbgrant,
  $dbvol = $::profile_mysql::params::dbvol,
) inherits ::profile_mysql::params {

  # validate parameters here
  class { '::profile_mysql::lvm': } ->
  class { '::profile_mysql::install': } ->
  class { '::profile_mysql::config': } ~>
  class { '::profile_mysql::service': } ->
  Class['::profile_mysql']
}

