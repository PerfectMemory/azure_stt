# frozen_string_literal: true

# frozen_string_literal

module AzureSTT
  module Parsers
    #
    # Parse the "nBest" field from the result file to a Models::Sentence
    #
    class Sentence < Base
      protected

      def build_attributes
        {
          confidence: hash['confidence'],
          lexical: hash['lexical'],
          itn: hash['itn'],
          masked_itn: hash['maskedITN'],
          display: hash['display'],
          words: build_words
        }.compact
      end

      private

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
