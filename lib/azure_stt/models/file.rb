# frozen_string_literal: true

module AzureSTT
  module Models
    #
    # Model class to represent files in our models
    #
    # @see https://francecentral.dev.cognitive.microsoft.com/docs/services/speech-to-text-api-v3-0/operations/GetTranscriptionFiles/console
    #
    class File < Base
      attribute :id, Types::Coercible::String
      attribute :name, Types::Coercible::String
      attribute :kind, Types::Coercible::String
      attribute :properties, Types::Coercible::Hash
      attribute :created_date_time, Types::Date
      attribute :content_url, Types::Coercible::String
    end
  end
end
