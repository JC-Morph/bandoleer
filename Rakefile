# frozen_string_literal: true

require 'bundler'
require 'cucumber/rake/task'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

Bundler::GemHelper.install_tasks

RSpec::Core::RakeTask.new
Cucumber::Rake::Task.new

RuboCop::RakeTask.new

desc 'Run the whole test suite'
task test: %i[spec cucumber]

task build:   %i[rubocop test]
task default: :test
