# frozen_string_literal: true

module AzureSTT
  module Models
    #
    # Model for a transcription. Contains the results and static methods to
    # create and retrieve the transcriptions.
    #
    class Transcription < Base
      attribute :model, Types::Coercible::String
      attribute :properties, Types::Hash
      attribute :links, Types::Hash
      attribute :last_action_date_time, Types::Date
      attribute :created_date_time, Types::Date
      attribute :status, Types::Coercible::String
      attribute :locale, Types::Coercible::String
      attribute :display_name, Types::Coercible::String

      def running?
        status == 'Running'
      end

      def failed?
        status == 'Failed'
      end

      def not_started?
        status == 'NotStarted'
      end

      def succeeded?
        status == 'Succeeded'
      end

      def finished?
        succeeded? || failed?
      end

      class << self
        #
        # Create a transcription by calling the API.
        #
        # @see https://centralus.dev.cognitive.microsoft.com/docs/services/speech-to-text-api-v3-0/operations/CreateTranscription
        #
        # @param [Array[String]] content_urls The urls of your files
        # @param [Hash] properties The properties you want to use for the
        # transcription
        # @param [String] locale The locale of the contained data
        # @param [String] display_name The name of the transcription (can be
        # left empty)
        #
        # @return [Transcription] The transcription
        #
        def create(content_urls:, properties:, locale:, display_name:)
          transcription_hash = AzureSTT.client.create_transcription(
            {
              contentUrls: content_urls,
              properties: properties,
              locale: locale,
              displayName: display_name
            }
          )
          new(Parsers::Transcription.new(transcription_hash).attributes)
        end
      end
    end
  end
end
