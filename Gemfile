source 'https://rubygems.org'

# Declare your gem's dependencies in dashing.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

gem 'sqlite3'

group :test, :development do
  gem 'rspec-rails', '~> 2.14'
  gem 'simplecov', require: false
  gem 'coveralls', require: false
  gem 'generator_spec', require: false
end
