# frozen_string_literal: true

module AzureSTT
  module Models
    #
    # Model class for the results of a transcription when the transcription is
    # successful
    #
    class Result < Base
      attribute :source, Types::Coercible::String
      attribute :timestamp, Types::Date
      attribute :duration_in_ticks, Types::Coercible::Integer
      attribute :duration, Types::Coercible::String
      attribute :combined_recognized_phrases,
                Types::Array.of(CombinedRecognizedPhrases).default([].freeze)
      attribute :recognized_phrases,
                Types::Array.of(RecognizedPhrase).default([].freeze)
    end
  end
end
