# frozen_string_literal: true

module AzureSTT
  module Models
    #
    # Model class to store a recognized phrase from the results file
    #
    class RecognizedPhrase
      attribute :recognitionStatus, Types::Coercible::String
      attribute :channel, Types::Coercible::Integer
      attribute? :speaker, Types::Coercible::Integer
      attribute? :offset, Types::Coercible::String
      attribute? :duration, Types::Coercible::String
      attribute? :offset_in_ticks, Types::Coercible::Integer
      attribute? :duration_in_ticks, Types::Coercible::Integer
      attribute :n_best, Types::Array.of(Sentence)
    end
  end
end
