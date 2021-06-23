# frozen_string_literal: true

module AzureSTT
  module Parsers
    #
    # Parse the words in the result file to Models::Word
    #
    class Word < Base
      protected

      #
      # Build the attributes needed to instantiate a Models::Word
      #
      # @return [Hash]
      #
      def build_attributes
        {
          word: hash['word'],
          offset: hash['offset'],
          duration: hash['duration'],
          offset_in_ticks: hash['offsetInTicks'],
          duration_in_ticks: hash['durationInTicks'],
          confidence: hash['confidence']
        }.compact
      end
    end
  end
end
