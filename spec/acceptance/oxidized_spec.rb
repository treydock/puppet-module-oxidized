require 'spec_helper_acceptance'

describe 'oxidized class:' do
  context 'default parameters' do
    it 'runs successfully' do
      pp = <<-EOS
      class { 'oxidized':
        with_service => true,
        devices      => [
          {'name' => 'router01.example.com', 'model' => 'ios'},
        ],
      }
      EOS

      on hosts, puppet('resource host router01.example.com ensure=present ip=127.0.0.1')
      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end
  end

  context 'install from source' do
    it 'runs successfully' do
      pp = <<-EOS
      class { 'oxidized':
        source_ensure => 'd5e516e9',
        with_service  => true,
        devices       => [
          {'name' => 'router01.example.com', 'model' => 'ios'},
        ],
      }
      EOS

      on hosts, puppet('resource host router01.example.com ensure=present ip=127.0.0.1')
      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end

    if fact('os.family') == 'RedHat' && fact('os.release.major') == '7'
      version_cmd = 'scl enable rh-ruby23 -- oxidized --version'
    else
      version_cmd = 'oxidized --version'
    end
    describe command(version_cmd) do
      its(:stdout) { is_expected.to match(%r{d5e516e9}) }
    end
  end
end
