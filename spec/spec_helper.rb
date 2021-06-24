# frozen_string_literal: true

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'dotenv'
require 'factory_bot'
require 'faker'
require 'rspec/its'
require 'simplecov'
require 'simplecov-lcov'
require 'webmock/rspec'

Dotenv.load

SimpleCov::Formatter::LcovFormatter.config do |c|
  c.report_with_single_file = true
  c.single_report_path = 'coverage/lcov.info'
end
SimpleCov.formatters = SimpleCov::Formatter::MultiFormatter.new(
  [
    SimpleCov::Formatter::HTMLFormatter,
    SimpleCov::Formatter::LcovFormatter
  ]
)

SimpleCov.start do
  add_filter ENV['GEM_HOME'] if ENV.fetch('GEM_HOME', '').include?('bundle')
  add_filter '.bundle'
  add_filter 'spec/support'
  add_group 'Library', 'lib'
  add_group 'Specs', 'spec'
end

require 'azure_stt'

# Require all support files
Dir.glob(File.join(__dir__, 'support', '**/*.rb')).sort.each do |file|
  require file
end

# Require all factories
Dir.glob(File.join(__dir__, 'factories', '**/*.rb')).sort.each do |file|
  require file
end

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.formatter = :documentation
  config.order = :rand

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
    mocks.verify_doubled_constant_names = true
  end

  config.include FactoryBot::Syntax::Methods
  config.include Helpers
end
