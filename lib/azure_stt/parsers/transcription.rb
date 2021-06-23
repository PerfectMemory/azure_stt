# frozen_string_literal: true

module AzureSTT
  module Parsers
    #
    # Parse a transcription from the call to the API to a Transcription
    #
    class Transcription < Base
      protected

      # rubocop:disable Metrics/AbcSize

      #
      # Build a hash which can create a Transcription
      #
      # @return [Hash] transcription's initializer parameters
      #
      def build_attributes
        {
          id: hash['self'].split('/').last,
          model: hash.dig('model', 'self'),
          links: hash['links'],
          properties: hash['properties'],
          last_action_date_time: Date.parse(hash['lastActionDateTime']),
          created_date_time: Date.parse(hash['createdDateTime']),
          status: hash['status'],
          locale: hash['locale'],
          display_name: hash['displayName']
        }
      end
      # rubocop:enable Metrics/AbcSize
    end
  end
end
