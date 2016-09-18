# coding: utf-8
# frozen_string_literal: true
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'file_care/version'

Gem::Specification.new do |spec|
  spec.name          = 'file_care'
  spec.version       = FileCare::VERSION
  spec.authors       = ['andela-ydaniju']
  spec.email         = ['yusuf.daniju@andela.com']

  spec.summary       = 'The file commands you did not find om Mac and Linux'
  spec.description   = 'Provides you with extra commands you can use for your'\
  ' files'
  spec.homepage      = 'https://github.com/andela-ydaniju/file_care'
  spec.license       = 'MIT'

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org/'
  else
    raise 'RubyGems 2.0 or newer is required to protect'\
    ' against public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rubocop', '~> 0.42'
  spec.add_development_dependency 'aruba', '~> 0.14'
end
