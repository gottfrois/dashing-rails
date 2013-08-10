require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new('default') do |t|
  t.pattern = FileList[File.expand_path('../spec/**/*_spec.rb', __FILE__)]
end
