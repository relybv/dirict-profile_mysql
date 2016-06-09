require 'spec_helper'

describe 'profile_mysql' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts.merge({
            :concat_basedir => "/foo",
            :memory => {
              'system' => {
                'total_bytes' => 4096
              }
            }
          })
        end

        context "profile_mysql class without any parameters" do
          let(:params) {{ }}

          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_class('profile_mysql') }
#          it { is_expected.to contain_class('profile_mysql::lvm') }
          it { is_expected.to contain_class('profile_mysql::install') }
          it { is_expected.to contain_class('profile_mysql::config') }
          it { is_expected.to contain_class('profile_mysql::params') }
          it { is_expected.to contain_class('profile_mysql::service') }

          it { is_expected.to contain_class('mysql::server') }
          it { is_expected.to contain_class('mysql::client') }

#          it { is_expected.to contain_physical_volume('/dev/vdb') }
#          it { is_expected.to contain_volume_group('dbvg') }
#          it { is_expected.to contain_logical_volume('dblv') }
#          it { is_expected.to contain_file('/var/lib/mysql') }
#          it { is_expected.to contain_filesystem('/dev/dbvg/dblv') }
#          it { is_expected.to contain_mount('/var/lib/mysql') }
#          it { is_expected.to contain_physical_volume('/dev/vdc') }
#          it { is_expected.to contain_volume_group('nfsvg') }
#          it { is_expected.to contain_logical_volume('nfslv') }
#          it { is_expected.to contain_file('/mnt/nfs') }
#          it { is_expected.to contain_filesystem('/dev/nfsvg/nfslv') }
#          it { is_expected.to contain_mount('/mnt/nfs') }

          it { is_expected.to contain_mysql__db('nd-app') }
          it { is_expected.to contain_mysql_database('nd-app') }
          it { is_expected.to contain_mysql_user('nd-app@%') }
        end
      end
    end
  end
end
