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

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.2"

  spec.required_ruby_version = '~> 2.1'
end
