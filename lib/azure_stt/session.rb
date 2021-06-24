# frozen_string_literal: true

module AzureSTT
  #
  # A session is the class the end user uses to retrieve the Transcription.
  # It contains a client.
  #
  class Session
    attr_reader :client

    #
    # Create a session. If you don't provide any subscription_key or region, the
    # value is read from configuration.
    #
    # @param [String] region The region, optional, default is read from
    # configuration
    # @param [String] subscription_key The subscription, optional, default is
    # read from configuration
    #
    def initialize(region: AzureSTT.configuration.region,
                   subscription_key: AzureSTT.configuration.subscription_key)
      @client = Client.new(region: region, subscription_key: subscription_key)
    end

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
    # @return [Models::Transcription] The transcription
    #
    def create_transcription(content_urls:, properties:, locale:, display_name:)
      transcription_hash = client.create_transcription(
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
    # @return [Models::Transcription] the transcription
    #
    def get_transcription(id)
      transcription_hash = client.get_transcription(id)
      build_transcription_from_hash(transcription_hash)
    end

    #
    # Get multiple transcriptions.
    #
    # @see https://centralus.dev.cognitive.microsoft.com/docs/services/speech-to-text-api-v3-0/operations/GetTranscriptions
    #
    # @param [Integer] skip Number of transcriptions that will be skipped (optional)
    # @param [Integer] top Number of transcriptions that will be included after skipping
    # (optional)
    #
    # @return [Array[Models::Transcription]]
    #
    def get_transcriptions(skip: nil, top: nil)
      transcriptions_array = client.get_transcriptions(skip: skip, top: top)
      transcriptions_array.map do |transcription_hash|
        build_transcription_from_hash(transcription_hash)
      end
    end

    private

    #
    # Build a transcription from a hash returned by the client. This hash
    # contains the information from the JSON. It is then parsed and the
    # transcription is intantiated.
    #
    # @param [Hash] hash The hash that the client returned
    #
    # @return [Models::Transcription] the created transcription
    #
    def build_transcription_from_hash(hash)
      Models::Transcription.new(
        Parsers::Transcription.new(hash).attributes.merge({ client: client })
      )
    end
  end
end
