# frozen_string_literal: true

module AzureSTT
  class Error < StandardError
    attr_reader :code, :message, :errors

    def initialize(code:, message:)
      super
      @code = code
      @message = message
    end

    def to_s
      "#{message} (#{code})"
    end
  end

  class ServiceError < Error; end

  class NetError < Error; end
end
