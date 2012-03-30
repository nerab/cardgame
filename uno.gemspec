# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "uno/version"

Gem::Specification.new do |s|
  s.name        = "uno"
  s.version     = Uno::VERSION
  s.authors     = ["Nicholas E. Rabenau"]
  s.email       = ["nerab@gmx.net"]
  s.homepage    = ""
  s.summary     = %q{Models the card game UNO}
  s.description = %q{This gem is a small exercise in OO modeling. It models the card game UNO.}

  s.rubyforge_project = "uno"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
