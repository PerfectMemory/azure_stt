# frozen_String_literal: true

module AzureSTT
  module Parsers
    #
    # Parse the CombinedRecognizedPhrases from the result file to a
    # Models::CombinedRecognizedPhrases
    #
    class CombinedRecognizedPhrases < Base
      protected

      #
      # Build a hash to instantiate a Models::CombinedRecognizedPhrase
      #
      # @return [Hash]
      #
      def build_attributes
        {
          channel: hash['channel'],
          lexical: hash['lexical'],
          itn: hash['itn'],
          masked_itn: hash['maskedITN'],
          transcript: hash['display']
        }.compact
      end
    end
  end
end
