# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lifelike/version'

Gem::Specification.new do |spec|
  spec.name          = "lifelike"
  spec.version       = Lifelike::VERSION
  spec.authors       = ["Max Holder"]
  spec.email         = ["mxhold@gmail.com"]
  spec.summary       = %q{Simulates Life-like cellular automata}
  spec.description   = %q{A gem for playing Conway's Game of Life and other Life-like cellular automata}
  spec.homepage      = "https://github.com/mxhold/lifelike"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.2"
  spec.add_development_dependency "byebug"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "metric_fu"
end
