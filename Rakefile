require 'bundler'
require 'cucumber/rake/task'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

Bundler::GemHelper.install_tasks

Cucumber::Rake::Task.new

RSpec::Core::RakeTask.new

RuboCop::RakeTask.new

desc 'Run the whole test suite.'
task test: %i[spec cucumber]

task default: :test
