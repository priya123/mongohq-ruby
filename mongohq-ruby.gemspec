# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "mongohq/version"

Gem::Specification.new do |s|
  s.name        = "mongohq"
  s.version     = MongoHQ::VERSION
  s.authors     = ["coderoshi"]
  s.email       = ["eric.redmond@gmail.com"]
  s.homepage    = "http://github.com/MongoHQ/mongohq-ruby"
  s.summary     = %q{Connects to MongoHQ API}
  s.description = %q{Connects to MongoHQ API}

  s.rubyforge_project = "mongohq"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "thor"
  s.add_dependency "faraday"
  s.add_development_dependency "rspec"
end
