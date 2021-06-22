# frozen_string_literal: true

module AzureSTT
  module Parsers
    #
    # Parse a report from a contentUrl to a Models::Report
    #
    class Report < Base
      protected

      #
      # Build a hash which can create a Models::Report
      #
      # @return [Hash] report's initializer parameters
      #
      def build_attributes
        {
          successful_transcriptions_count: hash[:successfulTranscriptionsCount],
          failed_transcriptions_count: hash[:failedTranscriptionsCount],
          details: hash[:details]
        }
      end
    end
  end
end
