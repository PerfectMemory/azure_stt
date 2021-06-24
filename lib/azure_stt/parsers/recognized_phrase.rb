# frozen_string_literal: true

module AzureSTT
  module Parsers
    #
    # Parse a recognized phrase from a result file to Models::RecognizedPhrase
    #
    class RecognizedPhrase < Base
      protected

      #
      # Build a hash to instantiate a Models::RecognizedPhrase
      #
      # @return [Hash]
      #
      def build_attributes
        {
          recognition_status: hash['recognitionStatus'],
          channel: hash['channel'],
          speaker: hash['speaker'],
          offset: hash['offset'],
          duration: hash['duration'],
          offset_in_ticks: hash['offsetInTicks'],
          duration_in_ticks: hash['durationInTicks'],
          n_best: build_n_best
        }.compact
      end

      private

      #
      # Build the n_best fiels if the RecognizedPhrase.
      #
      # @return [Array[Models::Sentence]]
      #
      def build_n_best
        hash['nBest'].map do |sentence_hash|
          Models::Sentence.new(
            Sentence.new(sentence_hash).attributes
          )
        end
      end
    end
  end
end
