# frozen_string_literal: true

module AzureSTT
  module Parsers
    #
    # Parse a file from the call to the API to a Models::File
    #
    class File < Base
      protected

      #
      # Build a hash which can create a Models::File
      #
      # @return [Hash] file's initializer parameters
      #
      def build_attributes
        {
          id: hash['self'].split('/').last,
          name: hash['name'],
          kind: hash['kind'],
          properties: hash['properties'],
          created_date_time: Date.parse(hash['createdDateTime']),
          content_url: hash.dig('links', 'contentUrl')
        }
      end
    end
  end
end
