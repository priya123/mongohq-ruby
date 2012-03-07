# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "mongohq/version"

Gem::Specification.new do |s|
  s.name        = "mongohq"
  s.version     = MongoHQ::VERSION
  s.authors     = ["coderoshi", "Chris Winslett"]
  s.email       = ["eric.redmond@gmail.com", "chris@mongohq.com"]
  s.homepage    = "http://github.com/MongoHQ/mongohq-ruby"
  s.summary     = %q{Connects to MongoHQ API and MongoHQ CLI}
  s.description = %q{Connects to MongoHQ API and MongoHQ CLI}

  s.rubyforge_project = "mongohq"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "thor"
  s.add_dependency "highline"
  s.add_dependency "faraday"
  s.add_dependency "hirb"
  s.add_dependency "json"
  s.add_development_dependency "rspec"
  s.add_development_dependency "fakeweb"
  s.add_development_dependency "guard"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "ruby_gntp" #growl notices, installs on ubuntu too
end
