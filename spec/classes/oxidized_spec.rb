require 'spec_helper'

describe 'oxidized' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }

      context 'when devices defined' do
        let(:params) { { devices: [{ 'name' => 'example', 'model' => 'ios' }] } }

        it { is_expected.to compile }
        it { is_expected.to contain_file('/home/oxidized/.config/oxidized/router.db').with_content(%r{^example:ios$}) }
      end
    end
  end
end
