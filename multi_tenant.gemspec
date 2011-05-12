# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "multi_tenant/version"

Gem::Specification.new do |s|
  s.name          = "multi_tenant"
  s.version       = MultiTenant::VERSION
  s.platform      = Gem::Platform::RUBY
  s.authors       = ["Mark Connell", "Chris Stefano"]
  s.email         = ["mark@markconnell.co.uk", "virtualstaticvoid@gmail.com"]
  s.homepage      = "https://github.com/virtualstaticvoid/multi_tenant"
  s.summary       = %q{Rails 3 Plugin to help build web apps that use a multi-tenant db architecture}
  s.description   = %q{MultiTenant is a Rails 3 plugin to help ease the development of web applications that utilise the database in a multi-tenant manner, and provide each end-user/account with their own subdomained version of the application.}
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.license       = "MIT"
end

