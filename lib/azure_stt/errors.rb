# frozen_string_literal: true

module AzureSTT
  #
  # Top level error for AzureSTT specific errors
  #
  class Error < StandardError
    attr_reader :code

    def initialize(code:, message:)
      @code = code
      super("#{message} (#{code})")
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
