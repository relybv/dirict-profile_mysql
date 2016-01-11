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
{
  class { '::mysql::server':
    remove_default_accounts => true,
  }

}
