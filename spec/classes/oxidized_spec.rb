require 'spec_helper'

describe 'oxidized' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }

      it { is_expected.to contain_package('oxidized-web').with_ensure('absent') }
      it { is_expected.to contain_file('/home/oxidized/.config/oxidized/config').with_content(%r{^rest: false$}) }

      context 'when devices defined' do
        let(:params) { { devices: [{ 'name' => 'example', 'model' => 'ios' }] } }

        it { is_expected.to compile }
        it { is_expected.to contain_file('/home/oxidized/.config/oxidized/router.db').with_content(%r{^example:ios$}) }
      end

      context 'when with_web => true' do
        let(:params) { { with_web: true } }

        it { is_expected.to compile }
        it { is_expected.to contain_package('oxidized-web').with_ensure('installed') }
        it { is_expected.to contain_file('/home/oxidized/.config/oxidized/config').with_content(%r{^rest: 127.0.0.1:8888$}) }
      end
    end
  end
end
