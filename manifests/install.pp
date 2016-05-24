# == Class profile_mysql::install
#
# This class is called from profile_mysql for install.
#
class profile_mysql::install {


  $override_options = {
  'mysqld' => {
    'innodb_file_per_table'           => '',
    'innodb_buffer_pool_size'         => '8G',
    'innodb_additional_mem_pool_size' => '20M',
    'thread_cache_size'               => '16',
    'max_connections'                 => '100',
    'query_cache_size'                => '128M',
    'bind_address'                    => '0.0.0.0',
  },
}
  class { '::mysql::server':
    remove_default_accounts => true,
    override_options        => $override_options,
  }

  class { '::mysql::client': }

}
