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

}
