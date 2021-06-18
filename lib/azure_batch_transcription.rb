# frozen_string_literal: true

#
# Top level module for Azure Batch Transcription
#
module AzureBatchTranscription
end

require_relative 'azure_batch_transcription/configuration'

AzureBatchTranscription.configure do |config|
  config.subscription_key = ENV.fetch('SUBSCRIPTION_KEY')
end
