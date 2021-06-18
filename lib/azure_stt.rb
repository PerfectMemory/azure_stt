# frozen_string_literal: true

#
# Top level module for Azure Batch Transcription
#
module AzureSTT
end

require_relative 'azure_stt/configuration'

AzureSTT.configure do |config|
  config.subscription_key = ENV.fetch('SUBSCRIPTION_KEY')
end
