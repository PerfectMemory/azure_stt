#!/usr/bin/env rake

# frozen_string_literal: true

$LOAD_PATH.unshift File.join(File.dirname(__FILE__), 'lib')

# rubocop:disable Lint/SuppressedException
begin
  require 'rspec/core/rake_task'

  desc 'Run RSpec unit tests only'
  RSpec::Core::RakeTask.new('spec') do |task|
    task.pattern = './spec/**/*_spec.rb'
    task.rspec_opts = '--tag ~unit'
  end
rescue LoadError
end

begin
  require 'rubocop/rake_task'

  RuboCop::RakeTask.new
rescue LoadError
end

begin
  require 'yard'

  YARD::Rake::YardocTask.new do |yard|
    yard.files = ['lib/**/*.rb', '-', 'CHANGELOG.md']
  end
rescue LoadError
end

task default: 'spec'
# rubocop:enable Lint/SuppressedException
