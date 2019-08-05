require 'puppet/provider/package'

Puppet::Type.type(:package).provide :scl_gem, parent: :gem do
  has_feature :versionable, :install_options
  commands gemcmd: '/usr/local/bin/scl_gem'
end
