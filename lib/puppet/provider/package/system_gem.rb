# frozen_string_literal: true

require 'puppet/provider/package'

Puppet::Type.type(:package).provide :system_gem, parent: :gem do
  desc 'Run gem command from system'
  has_feature :versionable, :install_options
  commands gemcmd: '/usr/bin/gem'
end
