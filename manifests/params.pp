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
}
