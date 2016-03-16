# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'multi_ruby_runner/version'

Gem::Specification.new do |spec|
  spec.name          = "multi_ruby_runner"
  spec.version       = MultiRubyRunner::VERSION
  spec.authors       = ["Jo Hund"]
  spec.email         = ["jhund@clearcove.ca"]
  spec.summary       = %q{Execute Ruby code in different Ruby environments.}
  spec.description   = %q{Execute Ruby code in different Ruby environments. This gem lets you for example call JRuby code from MRI. It relies on rbenv or RVM to manage the Ruby runtime environment.}
  spec.homepage      = "https://github.com/jhund/multi_ruby_runner"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
end
