# == Class profile_mysql::params
#
# This class is meant to be called from profile_mysql.
# It sets variables according to platform.
#
class profile_mysql::params {
  $dbname = 'nd-app'
  $dbuser = 'nd-app'
  $dbpassword = 'mypass'
  $dbgrant = ['GRANT', 'SELECT', 'INSERT', 'UPDATE', 'DELETE']
  $dbvol = '/dev/vdb'
  $nfsvol = '/dev/vdc'
  $innodb_buffer_pool_size         = '8G'
  $innodb_additional_mem_pool_size = '20M'
  $thread_cache_size               = '16'
  $max_connections                 = '100'
  $query_cache_size                = '128M'
}
