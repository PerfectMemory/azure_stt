# frozen_string_literal: true

module AzureSTT
  module Models
    #
    # Model for a transcription. Contains the results and static methods to
    # create and retrieve the transcriptions.
    #
    class Transcription < Base
      attribute :id, Types::Coercible::String
      attribute :model, Types::Coercible::String
      attribute :properties, Types::Hash
      attribute :links, Types::Hash
      attribute :last_action_date_time, Types::Date
      attribute :created_date_time, Types::Date
      attribute :status, Types::Coercible::String
      attribute :locale, Types::Coercible::String
      attribute :display_name, Types::Coercible::String
      attribute? :files, Types::Array.of(File).default([].freeze)

      #
      # Is the process still running ?
      #
      # @return [Boolean]
      #
      def running?
        status == 'Running'
      end

      #
      # Is the status is failed ?
      #
      # @return [Boolean]
      #
      def failed?
        status == 'Failed'
      end

      #
      # Is the process status is not_started ?
      #
      # @return [Boolean]
      #
      def not_started?
        status == 'NotStarted'
      end

      #
      # Has the process succeeded ?
      #
      # @return [Boolean]
      #
      def succeeded?
        status == 'Succeeded'
      end

      #
      # Is the process finished ? (Succeeded or failed)
      #
      # @return [Boolean]
      #
      def finished?
        succeeded? || failed?
      end

      #
      # Get the report of a transcription from transcriptions/{id}/files route
      #
      # @see https://centralus.dev.cognitive.microsoft.com/docs/services/speech-to-text-api-v3-0/operations/GetTranscriptionFiles/console
      #
      # @return [Models::Report]
      #
      def report
        @report ||= retrieve_report
      end

      def results; end

      #
      # Reinterrogate the API to refresh a transcription.
      #
      def refresh!
        transcription_hash = AzureSTT.client.get_transcription(id)
        parsed_attributes = Parsers::Transcription.new(transcription_hash).attributes
        @attributes = self.class.schema.call_unsafe(parsed_attributes)
        @report = nil
        @files = nil
        @results = nil
      end

      private

      #
      # All the files of a transcription
      #
      # @return [Array[File]] The files of the transcription
      #
      def files
        @files ||= retrieve_files
      end

      #
      # Interrogate the API to retrieve the files
      #
      # @return [Array[Files]] The files of the transcription
      #
      def retrieve_files
        files_array = AzureSTT.client.get_transcription_files(id)
        files_array.map do |file_hash|
          File.new(Parsers::File.new(file_hash).attributes)
        end
      end

      def retrieve_report
        report_file = files.find { |f| f.kind == 'TranscriptionReport' }
        file_hash = AzureSTT.client.get_file(report_file.content_url)
        Report.new(Parsers::Report.new(file_hash).attributes)
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
          build_transcription_from_hash(transcription_hash)
        end

        #
        # Get a transcription identified by an id.
        #
        # @see https://centralus.dev.cognitive.microsoft.com/docs/services/speech-to-text-api-v3-0/operations/GetTranscription
        #
        # @param [String] id The identifier of the transcription
        #
        # @return [Transcription] the transcription
        #
        def get(id)
          transcription_hash = AzureSTT.client.get_transcription(id)
          build_transcription_from_hash(transcription_hash)
        end

        #
        # Get multiple transcriptions
        #
        # @see https://centralus.dev.cognitive.microsoft.com/docs/services/speech-to-text-api-v3-0/operations/GetTranscriptions
        #
        # @param [Integer] skip Number of transcriptions that will be skipped (optional)
        # @param [Integer] top Number of transcriptions that will be included after skipping
        # (optional)
        #
        # @return [Array[Transcription]]
        #
        def get_multiple(skip: nil, top: nil)
          transcriptions_array = AzureSTT.client.get_transcriptions(skip: skip, top: top)
          transcriptions_array.map do |transcription_hash|
            build_transcription_from_hash(transcription_hash)
          end
        end

        private

        def build_transcription_from_hash(hash)
          new(Parsers::Transcription.new(hash).attributes)
        end
      end
    end
  end
end
