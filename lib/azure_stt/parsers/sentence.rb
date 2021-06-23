# frozen_string_literal: true

# frozen_string_literal

module AzureSTT
  module Parsers
    #
    # Parse the "nBest" field from the result file to a Models::Sentence
    #
    class Sentence < Base
      protected

      #
      # Build the attributes needed to instantiate a Models::Sentence
      #
      # @return [Hash]
      #
      def build_attributes
        {
          confidence: hash['confidence'],
          lexical: hash['lexical'],
          itn: hash['itn'],
          masked_itn: hash['maskedITN'],
          transcript: hash['display'],
          words: build_words
        }.compact
      end

      private

      #
      # Build the words. Returns nil if they are not defined
      #
      # @return [Array[Word]]
      #
      def build_words
        hash['words']&.map do |word_hash|
          Models::Word.new(
            Word.new(word_hash).attributes
          )
        end
      end
    end
  end
end
