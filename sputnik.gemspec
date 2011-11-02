# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "sputnik/version"

Gem::Specification.new do |s|
  s.name        = "sputnik"
  s.version     = Sputnik::VERSION
  s.authors     = ["coderoshi"]
  s.email       = ["eric.redmond@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Connects to MongoHQ API}
  s.description = %q{Connects to MongoHQ API}

  s.rubyforge_project = "sputnik"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec"
  s.add_runtime_dependency "faraday"
end
