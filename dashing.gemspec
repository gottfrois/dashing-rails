# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dashing/version'

Gem::Specification.new do |spec|
  spec.name         = 'dashing-rails'
  spec.version      = Dashing::VERSION
  spec.authors      = ['Pierre-Louis Gottfrois']
  spec.email        = ['pierrelouis.gottfrois@gmail.com']
  spec.description  = 'The exceptionally handsome dashboard framework for Rails.'
  spec.summary      = 'The exceptionally handsome dashboard framework for Rails.'
  spec.homepage     = 'https://github.com/gottfrois/dashing-rails'
  spec.license      = 'MIT'

  spec.files        = `git ls-files`.split($/)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'rails',                      '>= 4.0'
  spec.add_dependency 'jquery-rails',               '>= 3.0'
  spec.add_dependency 'coffee-script',              '>= 2.0'
  spec.add_dependency 'rufus-scheduler',            '~> 3.2'
  spec.add_dependency 'redis',                      '>= 3.2', '< 5.0'
  spec.add_dependency 'connection_pool',            '~> 2.2'

  spec.add_development_dependency 'bundler', '>= 1.8'
  spec.add_development_dependency 'pry-rails'
  spec.add_development_dependency 'better_errors'
end
