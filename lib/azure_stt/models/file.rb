# frozen_string_literal: true

module AzureSTT
  module Models
    #
    # Model class to represent files in our models
    #
    # @see https://francecentral.dev.cognitive.microsoft.com/docs/services/speech-to-text-api-v3-0/operations/GetTranscriptionFiles/console
    #
    class File < Base
      #
      # The id of the file
      #
      # @!attribute [r] id
      #   @return [Types::Coercible::String]
      attribute :id, Types::Coercible::String

      #
      # The name of the file
      #
      # @!attribute [r] name
      #   @return [Types::Coercible::String]
      attribute :name, Types::Coercible::String

      #
      # The kind of the file. It is useful to determine wether it is a
      # transcription result or a report
      #
      # @!attribute [r] kind
      #   @return [Types::Coercible::String]
      attribute :kind, Types::Coercible::String

      #
      # The properties you specified when you started the transcription
      #
      # @!attribute [r] properties
      #   @return [Types::Coercible::Hash]
      attribute :properties, Types::Coercible::Hash

      #
      # The date the file had been created
      #
      # @!attribute [r] created_date_time
      #   @return [Types::Date]
      attribute :created_date_time, Types::Date

      #
      # The url where you will be able to find the file. This url is valid only
      # for a period of time.
      #
      # @!attribute [r] content_url
      #   @return [Types::Coercible::String]
      attribute :content_url, Types::Coercible::String

      #
      # The client used to interrogate the API to get the content of the file
      #
      # @!attribute [r] client
      #   @return [AzureSTT::Client]
      attribute :client, Types.Instance(AzureSTT::Client)

      #
      # Returns the result of the request to the file with the url content_url
      #
      # @return [Hash]
      #
      def content
        client.get_file(content_url)
      end
    end
  end
end
