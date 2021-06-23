# frozen_string_literal: true

module AzureSTT
  module Models
    #
    # Model class for the results of a transcription when the transcription is
    # successful
    #
    class Result < Base
      #
      # The audio file source
      #
      # @!attribute [r] source
      #   @return [Types::Coercible::String]
      attribute :source, Types::Coercible::String

      #
      # The creation date of the result file
      #
      # @!attribute [r] timestamp
      #   @return [Types::Date]
      attribute :timestamp, Types::Date

      #
      # The duration of the audio in ticks
      #
      # @!attribute [r] duration_in_ticks
      #   @return [Types::Coercible::Integer]
      attribute :duration_in_ticks, Types::Coercible::Integer

      #
      # The duration of the audio in a String format
      #
      # @!attribute [r] duration
      #   @return [Types::Coercible::String]
      attribute :duration, Types::Coercible::String

      #
      # The transcript. It seems that the API generates one
      # 'combinedRecognizedPhrase per channel.
      #
      # @!attribute [r] combined_recognized_phrases
      #   @return [Types::Array.of(CombinedRecognizedPhrases)]
      attribute :combined_recognized_phrases,
                Types::Array.of(CombinedRecognizedPhrases).default([].freeze)

      #
      # The phrases that have been recognized from by the transcription
      #
      # @!attribute [r] recognized_phrases
      #   @return [Types::Array.of(RecognizedPhrases)]
      attribute :recognized_phrases,
                Types::Array.of(RecognizedPhrase).default([].freeze)

      #
      # The display field of the first CombinedRecognizedPhrases
      #
      # @return [String]
      #
      def text
        combined_recognized_phrases.first.transcript
      end

      #
      # Get all the best Models::Sentence of a result.
      #
      # @return [Array[Models::Sentence]]
      #
      def sentences
        recognized_phrases.map do |recognized_phrase|
          recognized_phrase.n_best.first
        end
      end
    end
  end
end
