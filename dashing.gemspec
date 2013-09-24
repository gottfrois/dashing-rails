$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'dashing/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'dashing-rails'
  s.version     = Dashing::VERSION
  s.authors     = ['Pierre-Louis Gottfrois']
  s.email       = ['pierrelouis.gottfrois@gmail.com']
  s.homepage    = 'https://github.com/gottfrois/dashing-rails'
  s.summary     = 'The exceptionally handsome dashboard framework for Rails.'
  s.description = 'The exceptionally handsome dashboard framework for Rails.'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['spec/**/*']

  s.add_dependency 'rails',                     '~> 4.0.0'
  s.add_dependency 'jquery-rails',              '~> 3.0.4'
  s.add_dependency 'coffee-script',             '~> 2.2.0'
  s.add_dependency 'rufus-scheduler',           '~> 2.0.23'
  s.add_dependency 'redis',                     '~> 3.0.4'
  s.add_dependency 'connection_pool',           '~> 1.1.0'

  s.add_development_dependency 'rspec-rails',   '~> 2.0'
  s.add_development_dependency 'pry-rails',     '~> 0.2.2'
  s.add_development_dependency 'better_errors', '~> 0.8.0'
end
