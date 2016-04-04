# == Class profile_mysql::lvm
#
# This class is called from profile_mysql for logical volume manager.
#
class profile_mysql::lvm {
  include lvm

  physical_volume { $::profile_mysql::dbvol:
    ensure => present,
  }

  volume_group { 'dbvg':
    ensure           => present,
    physical_volumes => $::profile_mysql::dbvol,
  }

  logical_volume { 'dblv':
    ensure       => present,
    volume_group => 'dbvg',
  #  size         => '20G',
  }

  filesystem { '/dev/dbvg/dblv':
    ensure  => present,
    fs_type => 'ext4',
}

}
