# frozen_string_literal: true

module AzureSTT
  #
  # Top level error for AzureSTT specific errors
  #
  class Error < StandardError
    attr_reader :code, :message, :errors

    def initialize(code:, message:)
      super
      @code = code
      @message = message
    end

    #
    # Format the message for the errors to display the message and the code
    #
    # @return [String] The message error
    #
    def to_s
      "#{message} (#{code})"
    end
  end

  #
  # Error raised when there is an error 400
  #
  class ServiceError < Error; end

  #
  # Error raised when there is an error 500
  #
  class NetError < Error; end
end
