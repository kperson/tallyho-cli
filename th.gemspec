# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'th/version'

Gem::Specification.new do |spec|
  spec.name          = "th"
  spec.version       = TH::VERSION
  spec.authors       = ["Kelton Person"]
  spec.email         = ["kelton.person@gmail.com"]
  spec.summary       = 'TallyHo cli client'
  spec.description   = 'A CLI client to control to a TallHo cluster'
  spec.homepage      = "https://github.com/kperson/kay-clt"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = ["th"]
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"

  spec.add_runtime_dependency 'rest-client', '~> 1.6.7'
  spec.add_runtime_dependency 'colorize'

end
