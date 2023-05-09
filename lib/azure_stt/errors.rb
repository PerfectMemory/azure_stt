# frozen_string_literal: true

module AzureSTT
  #
  # Top level error for AzureSTT specific errors
  #
  class Error < StandardError; end

  #
  # Error raised when there is an error 400
  #
  class ServiceError < Error
    attr_reader :code

    def initialize(code:, message:, azure_message:)
      @code = code
      super("#{message} (#{code}): #{azure_message}")
    end
  end

  #
  # Error raised when there is an error 500
  #
  class NetError < Error
    attr_reader :code

    def initialize(code:, message:)
      @code = code
      super("#{message} (#{code})")
    end
  end
end
