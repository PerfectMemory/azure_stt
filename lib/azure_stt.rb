# frozen_string_literal: true

#
# Top level module for AzureSTT
#
module AzureSTT
end

require_relative 'azure_stt/version'
require_relative 'azure_stt/configuration'
require_relative 'azure_stt/errors'
require_relative 'azure_stt/client'
require_relative 'azure_stt/models'
require_relative 'azure_stt/parsers'
require_relative 'azure_stt/session'

AzureSTT.configure do |config|
  config.subscription_key = ENV['SUBSCRIPTION_KEY']
  config.region = ENV['REGION']
end
