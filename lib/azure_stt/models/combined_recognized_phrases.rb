# frozen_string_literal: true

module AzureSTT
  module Models
    #
    # Model class for the combinedRecognizedPhrases field in the results of
    # the transcriptions
    #
    class CombinedRecognizedPhrases < Base
      attribute :channel, Types::Coercible::Integer
      attribute :lexical, Types::Coercible::String
      attribute :itn, Types::Coercible::String
      attribute :masked_itn, Types::Coercible::String
      attribute :display, Types::Coercible::String
    end
  end
end
