# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cuda/version'
require 'cuda/server'
require 'cuda/handler'
require 'cuda/request'
require 'cuda/response'
require 'cuda/template'
require 'cuda/mime'
require 'date'

Gem::Specification.new do |gem|
  gem.name          = "cuda"
  gem.version       = Cuda::VERSION
  gem.authors       = ["Bruno"]
  gem.email         = ["b.fbohn@gmail.com"]
  gem.description   = %q{Cuda - simple client and server}
  gem.summary       = %q{Cuda - simple client and server}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency('rake')
  gem.add_development_dependency('rspec')
  gem.add_runtime_dependency('gli','2.5.6')

end
