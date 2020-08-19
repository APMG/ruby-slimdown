# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'slimdown/version'

Gem::Specification.new do |spec|
  spec.name          = "slimdown"
  spec.version       = Slimdown::VERSION
  spec.authors       = ["William Johnston"]
  spec.email         = ["wjohnston@mpr.org"]

  spec.summary       = %q{A system for using static Markdown for pages.}
  spec.description   = %q{A system for using Markdown from a folder and turning it into web pages.}
  spec.homepage      = "https://github.com/APMG/ruby-slimdown"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 1.9.3'

  spec.add_runtime_dependency 'kramdown', '~> 2.3'

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency "guard", "~> 2.12"
  spec.add_development_dependency "guard-rspec", "~> 4.5"
  spec.add_development_dependency "pry", "~> 0.10"
  spec.add_development_dependency "yard", "~> 0.9.11"
end
