# frozen_string_literal: true

module AzureSTT
  module Models
    #
    # Base class for the models
    #
    class Base < Dry::Struct
      # throw an error when unknown keys provided
      schema schema.strict

      # convert string keys to symbols
      transform_keys(&:to_sym)

      # resolve default types on nil
      transform_types do |type|
        if type.default?
          type.constructor do |value|
            value.nil? ? Dry::Types::Undefined : value
          end
        else
          type
        end
      end
    end
  end
end
