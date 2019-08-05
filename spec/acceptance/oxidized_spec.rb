require 'spec_helper_acceptance'

describe 'oxidized class:' do
  context 'default parameters' do
    it 'runs successfully' do
      pp = <<-EOS
      class { 'oxidized':
        devices => [
          {'name' => 'router01.example.com', 'model' => 'ios'},
        ]
      }
      EOS

      apply_manifest(pp, catch_failures: true, debug: true)
      apply_manifest(pp, catch_changes: true, debug: true)
    end
  end
end
