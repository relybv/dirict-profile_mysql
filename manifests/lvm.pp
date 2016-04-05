# == Class profile_mysql::lvm
#
# This class is called from profile_mysql for logical volume manager.
#
class profile_mysql::lvm {

  class { '::lvm':
    manage_pkg    => true,
  }

  physical_volume { $::profile_mysql::dbvol:
    ensure => present,
  }

  physical_volume { $::profile_mysql::nfsvol:
    ensure => present,
  }

  volume_group { 'dbvg':
    ensure           => present,
    physical_volumes => $::profile_mysql::dbvol,
  }

  volume_group { 'nfsvg':
    ensure           => present,
    physical_volumes => $::profile_mysql::nfsvol,
  }

  logical_volume { 'dblv':
    ensure       => present,
    volume_group => 'dbvg',
  }

  logical_volume { 'nfslv':
    ensure       => present,
    volume_group => 'nfsvg',
  }

  filesystem { '/dev/dbvg/dblv':
    ensure  => present,
    fs_type => 'ext4',
    atboot  => true,
  }

  filesystem { '/dev/nfsvg/nfslv':
    ensure  => present,
    fs_type => 'ext4',
    atboot  => true,
  }

  file { '/var/lib/mysql':
    ensure => directory,
  }

  file { '/mnt/nfs':
    ensure => directory,
  }

  mount { '/var/lib/mysql':
    ensure => mounted,
    device => '/dev/dbvg/dblv',
    fstype => 'ext4',
  }

  mount { '/mnt/nfs':
    ensure => mounted,
    device => '/dev/nfsvg/nfslv',
    fstype => 'ext4',
  }

}
