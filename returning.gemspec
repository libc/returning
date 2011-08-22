# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "returning/version"

Gem::Specification.new do |s|
  s.name        = "returning"
  s.version     = Returning::VERSION
  s.authors     = ["Eugene Pimenov"]
  s.email       = ["eugene@soocial.com"]
  s.homepage    = "http://github.com/libc/returning"
  s.summary     = %q{Add PostgreSQL RETURNING thingie to ActiveRecord}
  s.description = %q{Simple implementation of RETURNING for ActiveRecord}

  s.rubyforge_project = "returning"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'activerecord', '>= 3.0'
  s.add_development_dependency 'rspec', '~> 2.0'
end
