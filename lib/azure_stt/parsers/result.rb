# frozen_string_literal: true

module AzureSTT
  module Parsers
    #
    # Parse a result file from the API to a Models::Result
    #
    class Result < Base
      protected

      #
      # Build a hash which can create a Models::Result
      #
      # @return [Hash] report's initializer parameters
      #
      def build_attributes
        {
          source: hash[:source],
          timestamp: Date.parse(hash[:timestamp]),
          duration_in_ticks: hash[:durationInTicks],
          duration: hash[:dureation],
          combined_recognized_phrases: build_combined_recognized_phrases,
          recognized_phrases: build_recognized_phrases
        }
      end

      private

      def build_combined_recognized_phrases
        hash[:combinedRecognizedPhrases].map do |combined_phrases_hash|
          Models::CombinedRecognizedPhrases.new(
            CombinedRecognizedPhrases.new(combined_phrases_hash).attributes
          )
        end
      end

      def build_recognized_phrases
        hash[:recognizedPhrases].map do |recognized_phrase_hash|
          Models::RecognizedPhrase.new(
            RecognizedPhrase.new(recognized_phrase_hash).attributes
          )
        end
      end
    end
  end
end
