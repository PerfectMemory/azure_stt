# frozen_string_literal: true

#
# Top level module for Azure Batch Transcription
#
module AzureSTT
  class << self
    #
    # Create or return the existing client to communicate with the API
    #
    # @return [AzureSTT::Client]
    #
    def client
      @client ||= configure_client
    end

    private

    def configure_client
      Client.new(region: configuration.region, subscription_key: configuration.subscription_key)
    end
  end
end

require_relative 'azure_stt/configuration'
require_relative 'azure_stt/errors'
require_relative 'azure_stt/client'
require_relative 'azure_stt/models'
require_relative 'azure_stt/parsers'

AzureSTT.configure do |config|
  config.subscription_key = ENV.fetch('SUBSCRIPTION_KEY')
  config.region = ENV.fetch('REGION')
end
