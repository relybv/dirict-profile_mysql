# == Class profile_mysql::lvm
#
# This class is called from profile_mysql for logical volume manager.
#
class profile_mysql::lvm {

  class { '::lvm':
    manage_pkg    => true,
  }

  physical_volume { $::profile_mysql::dbvol:
    ensure  => present,
    require => Class['::lvm'],
  }

  physical_volume { $::profile_mysql::nfsvol:
    ensure  => present,
    require => Class['::lvm'],
  }

  volume_group { 'dbvg':
    ensure           => present,
    physical_volumes => $::profile_mysql::dbvol,
    require          => Physical_volume[$::profile_mysql::dbvol],
  }

  volume_group { 'nfsvg':
    ensure           => present,
    physical_volumes => $::profile_mysql::nfsvol,
    require          => Physical_volume[$::profile_mysql::nfsvol],
  }

  logical_volume { 'dblv':
    ensure       => present,
    volume_group => 'dbvg',
    require      => Volume_group['dbvg'],
  }

  logical_volume { 'nfslv':
    ensure       => present,
    volume_group => 'nfsvg',
    require      => Volume_group['nfsvg'],
  }

  filesystem { '/dev/dbvg/dblv':
    ensure  => present,
    fs_type => 'ext4',
    atboot  => true,
    require => Logical_volume['dblv'],
  }

  filesystem { '/dev/nfsvg/nfslv':
    ensure  => present,
    fs_type => 'ext4',
    atboot  => true,
    require => Logical_volume['nfslv'],
  }

  file { '/var/lib/mysql':
    ensure => directory,
  }

#  file { '/mnt/nfs':
#    ensure => directory,
#  }

  mount { '/var/lib/mysql':
    ensure  => mounted,
    device  => '/dev/dbvg/dblv',
    fstype  => 'ext4',
    require => [ File[ '/var/lib/mysql'], Filesystem['/dev/dbvg/dblv'] ],
  }

  mount { '/mnt/nfs':
    ensure  => mounted,
    device  => '/dev/nfsvg/nfslv',
    fstype  => 'ext4',
    require => Filesystem['/dev/nfsvg/nfslv'],
  }

}
