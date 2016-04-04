# == Class profile_mysql::lvm
#
# This class is called from profile_mysql for logical volume manager.
#
class profile_mysql::lvm {

  class { '::lvm':
    manage_pkg    => true,
    volume_groups => {
      'dbvg' => {
        physical_volumes => [ $::profile_mysql::dbvol ],
        logical_volumes  => {
          'dblv' => { },
        },
      },
    },
  }

  physical_volume { $::profile_mysql::nfsvol:
    ensure => present,
  }

  volume_group { 'nfsvg':
    ensure           => present,
    physical_volumes => $::profile_mysql::nfsvol,
  }

  logical_volume { 'nfslv':
    ensure            => present,
    volume_group      => 'nfsvg',
    mountpath_require => true,
  }

  filesystem { '/dev/nfsvg/nfslv':
    ensure  => present,
    fs_type => 'ext4',
    atboot  => true,
  }

}
