# frozen_string_literal: true

module AzureSTT
  #
  # Model for a transcription. Contains the results and static methods to
  # create and retrieve the transcriptions.
  #
  class Transcription < Models::Base
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
    # @see https://centralus.dev.cognitive.microsoft.com/docs/services/speech-to-text-api-v3-0/operations/GetTranscriptionFiles/console
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
        Models::File.new(Parsers::File.new(file_hash).attributes)
      end
    end

    def retrieve_report
      report_file = files.find { |f| f.kind == 'TranscriptionReport' }
      file_hash = client.get_file(report_file.content_url)
      Models::Report.new(Parsers::Report.new(file_hash).attributes)
    end

    def retrieve_results
      results_files = files.select { |f| f.kind == 'Transcription' }
      results_files.map do |result_file|
        result_hash = client.get_file(result_file.content_url)
        Models::Result.new(Parsers::Result.new(result_hash).attributes)
      end
    end
  end
end
