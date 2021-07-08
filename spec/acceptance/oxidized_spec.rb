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
end
