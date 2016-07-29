# == Class profile_mysql::install
#
# This class is called from profile_mysql for install.
#
class profile_mysql::install {
  # prevent direct use of subclass
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  # always do apt-get update before installing packages
  exec { 'apt-update':
    command => '/usr/bin/apt-get update',
  }

  Exec['apt-update'] -> Package <| |>

  # mysql options
  $override_options = {
  'mysqld' => {
    'innodb_file_per_table'           => '',
    'innodb_buffer_pool_size'         => $::profile_mysql::innodb_buffer_pool_size,
    'innodb_additional_mem_pool_size' => $::profile_mysql::innodb_additional_mem_pool_size,
    'thread_cache_size'               => $::profile_mysql::thread_cache_size,
    'max_connections'                 => $::profile_mysql::max_connections,
    'query_cache_size'                => $::profile_mysql::query_cache_size,
    'bind_address'                    => '0.0.0.0',
    'innodb_flush_method'             => 'O_DSYNC',
    'innodb_buffer_pool_instances'    => '2',
  },
}

  class { '::mysql::server':
    remove_default_accounts => true,
    override_options        => $override_options,
  }

  class { '::mysql::client': }

}
