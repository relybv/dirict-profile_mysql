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
          it { is_expected.to contain_class('profile_mysql::install') }
          it { is_expected.to contain_class('profile_mysql::config') }
          it { is_expected.to contain_class('profile_mysql::params') }
          it { is_expected.to contain_class('profile_mysql::service') }

          it { is_expected.to contain_class('mysql::server') }
          it { is_expected.to contain_class('mysql::client') }

          it { is_expected.to contain_cron('bkudb') }

          it { is_expected.to contain_file('/root/backup.sh') }

          it { is_expected.to contain_mysql_user('nd-app@%') }
          it { is_expected.to contain_Mysql_grant('nd-app@%/*.*') }
        end
      end
    end
  end
end
