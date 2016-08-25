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
  $dbuser = $::profile_mysql::params::dbuser,
  $dbpassword = $::profile_mysql::params::dbpassword,
  $dbgrant = $::profile_mysql::params::dbgrant,
  $dbvol = $::profile_mysql::params::dbvol,
  $nfsvol = $::profile_mysql::params::nfsvol,
  $innodb_buffer_pool_size         = $::profile_mysql::params::innodb_buffer_pool_size,
  $innodb_additional_mem_pool_size = $::profile_mysql::params::innodb_additional_mem_pool_size,
  $thread_cache_size               = $::profile_mysql::params::thread_cache_size,
  $max_connections                 = $::profile_mysql::params::max_connections,
  $query_cache_size                = $::profile_mysql::params::query_cache_size,
) inherits ::profile_mysql::params {

  # validate parameters here
#  validate_string($dbname)
#  validate_string($dbuser)
#  validate_string($dbpassword)
#  validate_array($dbgrant)
  validate_string($dbvol)
  validate_string($nfsvol)
  validate_string($innodb_buffer_pool_size)
  validate_string($innodb_additional_mem_pool_size)
  validate_string($thread_cache_size)
  validate_numeric($max_connections)
  validate_string($query_cache_size)

  if 'vdb' in $::disks {
    class { '::profile_mysql::lvm':
      notify => Class[ '::profile_mysql::install' ],
    }
  }
  class { '::profile_mysql::install': } ->
  class { '::profile_mysql::config': } ~>
  class { '::profile_mysql::service': } ->
  Class['::profile_mysql']
}

