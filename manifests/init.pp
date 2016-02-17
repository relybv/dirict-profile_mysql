# == Class: profile_mysql
#
# Full description of class profile_mysql here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class profile_mysql
(
  $packages = $::profile_mysql::params::packages,
) inherits ::profile_mysql::params {

  # validate parameters here

  class { '::profile_mysql::install': } ->
  class { '::profile_mysql::config': } ~>
  class { '::profile_mysql::service': } ->
  Class['::profile_mysql']
}

