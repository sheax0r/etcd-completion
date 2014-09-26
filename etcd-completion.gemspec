# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'etcd/completion/version'

Gem::Specification.new do |spec|
  spec.name          = "etcd-completion"
  spec.version       = Etcd::Completion::VERSION
  spec.authors       = ["Michael Shea"]
  spec.email         = ["mike.shea@gmail.com"]
  spec.summary       = %q{Utility for etcd autocompletion}
  spec.description   = %q{Lists possible node matches based on operation}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"

  spec.add_dependency 'etcd', "~> 0.2"
end
