# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rasana/version'

Gem::Specification.new do |spec|
  spec.name          = 'rasana'
  spec.version       = Rasana::VERSION
  spec.authors       = ['memerelics']
  spec.email         = ['takuya21hashimoto@gmail.com']
  spec.description   = %q{Asana client written in Ruby}
  spec.summary       = %q{Asana client written in Ruby}
  spec.homepage      = 'https://github.com/memerelics/rasana'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'bundler', '~> 1.3'
  spec.add_dependency 'rake'
  spec.add_dependency 'faraday', '~> 0.8.7'
  spec.add_dependency 'faraday_middleware', '~> 0.9.0'
  spec.add_dependency 'thor', '~> 0.18.1'
  spec.add_dependency 'hashie'

  # dev
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rubocop'
end
