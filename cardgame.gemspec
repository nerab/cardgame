# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "cardgame/version"

Gem::Specification.new do |s|
  s.name        = "cardgame"
  s.version     = CardGame::VERSION
  s.authors     = ["Nicholas E. Rabenau"]
  s.email       = ["nerab@gmx.net"]
  s.homepage    = ""
  s.summary     = %q{Models card games, e.g. Uno}
  s.description = %q{This gem is a small exercise in OO modeling. It models card games, especially Uno.}

  s.rubyforge_project = "cardgame"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency 'pry', '~> 0.9'
  s.add_runtime_dependency 'activesupport', '~> 3.2'
end
