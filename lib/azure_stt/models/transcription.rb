# frozen_string_literal: true

module AzureSTT
  module Models
    #
    # Model for a transcription. Contains the results and static methods to
    # create and retrieve the transcriptions.
    #
    class Transcription < Base
      #
      # The id of the transcription
      #
      # @!attribute [r] id
      #   @return [Types::Coercible::String]
      attribute :id, Types::Coercible::String

      #
      # The model url of the transcription
      #
      # @!attribute [r] model
      #   @return [Types::Coercible::String]
      attribute :model, Types::Coercible::String

      #
      # The properties of the transcription
      #
      # @!attribute [r] properties
      #   @return [Types::Hash]
      attribute :properties, Types::Hash

      #
      # The links for the transcription (usually just a link to the files route)
      #
      # @!attribute [r] links
      #   @return [Types::Hash]
      attribute :links, Types::Hash

      #
      # The last date the transcription has been updated
      #
      # @!attribute [r] last_action_date_time
      #   @return [Types::Date]
      attribute :last_action_date_time, Types::Date

      #
      # The date the transcription has been created
      #
      # @!attribute [r] created_date_time
      #   @return [Types::Date]
      attribute :created_date_time, Types::Date

      #
      # The status of the transcription
      #
      # @!attribute [r] status
      #   @return [Types::Coercible::String]
      attribute :status, Types::Coercible::String

      #
      # The locale of the transcription. Example: 'en-US'
      #
      # @!attribute [r] locale
      #   @return [Types::Coercible::String]
      attribute :locale, Types::Coercible::String

      #
      # The displayName of the transcription, not unique
      #
      # @!attribute [r] display_name
      #   @return [Types::Coercible::String]
      attribute :display_name, Types::Coercible::String

      #
      # The transcription's files that can be retrieve
      #
      # @!attribute [r] files
      #   @return [Types::Array.of(File)]
      attribute? :files, Types::Array.of(File).default([].freeze)

      #
      # The client used to interrogate the API
      #
      # @!attribute [r] client
      #   @return [AzureSTT::Client]
      attribute :client, Types.Instance(AzureSTT::Client)

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
      # Get the report of a transcription from transcriptions/id/files route
      #
      # @see https://centralus.dev.cognitive.microsoft.com/docs/services/speech-to-text-api-v3-1/operations/GetTranscriptionFiles/console
      #
      # @return [Models::Report]
      #
      def report
        @report ||= retrieve_report
      end

      #
      # Get the results of a transcription. The results are the files containing
      # the speech-to-text. As a transcription process can have multiple files,
      # the results are in an Array.
      #
      # @return [Array[Models::Result]]
      #
      def results
        @results ||= retrieve_results
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
        files_array = client.get_transcription_files(id)
        files_array.map do |file_hash|
          Models::File.new(
            Parsers::File.new(file_hash).attributes.merge({ client: client })
          )
        end
      end

      def retrieve_report
        report_file = files.find { |f| f.kind == 'TranscriptionReport' }
        file_hash = report_file.content
        Models::Report.new(Parsers::Report.new(file_hash).attributes)
      end

      def retrieve_results
        results_files = files.select { |f| f.kind == 'Transcription' }
        results_files.map do |result_file|
          result_hash = result_file.content
          Models::Result.new(Parsers::Result.new(result_hash).attributes)
        end
      end
    end
  end
end
