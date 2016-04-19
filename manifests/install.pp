# == Class profile_mysql::install
#
# This class is called from profile_mysql for install.
#
class profile_mysql::install {

#  file { '/etc/mysql':
#    ensure => directory,
#  }
  class { '::mysql::server':
    remove_default_accounts => true,
#    require                 => File['/etc/mysql'],
  }

  class { '::mysql::client': }

}
