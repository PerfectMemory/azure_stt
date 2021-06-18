# frozen_string_literal: true

module AzureSTT
  #
  # Configurator pattern to be able to change the subscription key. By default
  # the key is in a .env file
  #
  class Configuration
    attr_accessor :subscription_key
  end

  #
  # Get the configuration for Azure Batch Transcription
  #
  # @return [Configuration]
  #
  def self.configuration
    @configuration ||= Configuration.new
  end

  #
  # Modify the configuration
  #
  def self.configure
    yield configuration
  end
end
