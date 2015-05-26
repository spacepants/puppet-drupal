require 'spec_helper'

describe 'drupal' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts.merge!(:concat_basedir => '/dne')
        end

        context "drupal class without any parameters" do
          let(:params) {{ }}

          it { is_expected.to compile.with_all_deps }
          # class and dependency specs
          it { is_expected.to contain_class('drupal') }
          it { is_expected.to contain_class('drupal::params') }
          it { is_expected.to contain_anchor('::drupal::begin').that_comes_before('drupal::drush') }
          it { is_expected.to contain_class('drupal::drush').that_comes_before('drupal::install') }
          it { is_expected.to contain_class('drupal::install') }
          it { is_expected.to contain_class('drupal::cacheclear') }
          it { is_expected.to contain_anchor('::drupal::end').that_requires('drupal::cacheclear') }

          it { is_expected.to contain_class('drupal::drush::install').that_comes_before('drupal::drush::config') }
          it { is_expected.to contain_class('drupal::drush::config') }

          # drush specs
          it { is_expected.to contain_file('/opt/drush').with_ensure('directory') }
          it { is_expected.to contain_exec('install drush').with_command('/usr/local/bin/composer require drush/drush:dev-master') }
          it { is_expected.to contain_file('/usr/local/bin/drush').with_target('/opt/drush/vendor/bin/drush') }
          it { is_expected.to contain_file('/usr/bin/drush').with_target('/usr/local/bin/drush') }
          it { is_expected.to contain_exec('drush status').with_refreshonly(true) }
          it { is_expected.to contain_file('/etc/drush').with_ensure('directory') }
          it { is_expected.to contain_file('/usr/share/drush').with_ensure('directory') }
          it { is_expected.to contain_file('/usr/share/drush/commands').with_ensure('directory') }
          it { is_expected.to contain_file('/etc/profile.d/drushrc.sh').with_target('/opt/drush/vendor/drush/drush/examples/example.bashrc') }
          it { is_expected.to contain_file('/etc/bash_completion.d/drush').with_target('/opt/drush/vendor/drush/drush/drush.complete.sh') }
          it { is_expected.to contain_drupal__drush__extension('dslm') }
          it { is_expected.to contain_exec('/usr/local/bin/drush dl dslm-7.x-2.x-dev') }

          it { is_expected.to contain_file('/var/drupal').with_ensure('directory') }
          it { is_expected.to contain_file('/var/drupal/cores').with_ensure('directory') }
          it { is_expected.to contain_file('/var/drupal/profiles').with_ensure('directory') }
          it { is_expected.to contain_drupal__core('7.37') }
          it { is_expected.to contain_exec('/usr/local/bin/drush dl drupal-7.37') }

          it { is_expected.to contain_exec('cc drush').with_refreshonly(true) }

        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'drupal class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { is_expected.to contain_package('drupal') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
