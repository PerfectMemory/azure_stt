# frozen_string_literal: true

module AzureSTT
  module Parsers
    #
    # Base class for the parsers
    #
    class Base
      attr_reader :hash

      #
      # Initialize the parser
      #
      # @param [Hash] hash The hash containing the information from the API
      #
      def initialize(hash)
        @hash = hash.transform_keys(&:to_sym)
      end

      #
      # Get the attributes parsed to be able to build the model
      #
      # @return [Hash]
      #
      def attributes
        @attributes ||= build_attributes
      end

      protected

      #
      # This method must be overriden in the children
      #
      # @return [Hash] The attributes parsed to be able to build the model
      #
      def build_attributes
        raise NoMethodError, 'Implement method #build_attributes in your' \
                             'custom parser'
      end
    end
  end
end
