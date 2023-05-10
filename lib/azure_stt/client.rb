# frozen_string_literal: true

require 'httparty'
module AzureSTT
  #
  # Client class that uses HTTParty to communicate with the API
  #
  class Client
    include HTTParty

    attr_reader :region, :subscription_key

    #
    # Initialize the client
    #
    # @param [String] subscription_key Cognitive Services API Key
    # @param [String] region The region of your resources
    #
    def initialize(region:, subscription_key:)
      @subscription_key = subscription_key
      @region = region
      self.class.base_uri "https://#{region}.api.cognitive.microsoft.com/speechtotext/v3.1"
    end

    #
    # Create a transcription for a batch or a single file.
    #
    # @see https://francecentral.dev.cognitive.microsoft.com/docs/services/speech-to-text-api-v3-1/operations/CreateTranscription
    #
    # @param [Hash] args
    #
    # @return [Hash] The JSON body response, parsed by HTTParty
    #
    def create_transcription(**args)
      results = post(
        '/transcriptions',
        args.to_json
      )

      results.parsed_response
    end

    #
    # Get a transcription by giving it's id
    #
    # @param [String] id The identifier of the transcription
    #
    # @return [Hash] The JSON body response, parsed by HTTParty
    #
    def get_transcription(id)
      results = get("/transcriptions/#{id}")

      results.parsed_response
    end

    #
    # Get an Array of all the transcriptions
    #
    # @param [Integer] skip Number of transcriptions that will be skipped (optional)
    # @param [Integer] top Number of transcriptions that will be included (optional)
    #
    # @return [Array[Hash]] Array of all the transcriptions. The transcriptions
    # are Hashes parsed by HTTParty.
    #
    def get_transcriptions(skip: nil, top: nil)
      results = get(
        '/transcriptions',
        {
          skip: skip,
          top: top
        }.compact
      )

      results.parsed_response['values']
    end

    #
    # Delete a transcription with a given ID
    #
    # @param [String] id The id of the transcription in the API
    #
    # @return [Boolean] true if the transcription had been deleted, raises an error else
    #
    def delete_transcription(id)
      response = self.class.delete("/transcriptions/#{id}", headers: headers)
      handle_response(response)

      true
    end

    #
    # Get an array containing the files for a given transcription
    #
    # @see https://uscentral.dev.cognitive.microsoft.com/docs/services/speech-to-text-api-v3-1/operations/GetTranscriptionFiles
    #
    # @param [Integer] id The identifier of the transcription
    #
    # @return [Array[Hash]] Array of the files of a transcription
    #
    def get_transcription_files(id)
      results = get("/transcriptions/#{id}/files")

      results.parsed_response['values']
    end

    #
    # Read a JSON file and parse it.
    #
    # @param [String] file_url The url of the content
    #
    # @return [Hash] the file parsed
    #
    def get_file(file_url)
      response = self.class.get(file_url)

      results = handle_response(response)

      results.parsed_response
    end

    private

    #
    # Make a post request by giving a path and a body
    #
    # @param [String] path the path, which is added to the base_uri
    # @param [String] body the body of the request
    #
    # @return [HTTParty::Response]
    #
    def post(path, body)
      options = {
        headers: headers,
        body: body
      }

      response = self.class.post(path, options)
      handle_response(response)
    end

    #
    # Make a get request to the API.
    #
    # @param [String] path the path, which is added to the base_uri
    # @param [Hash] parameters The parameters you want to add to the headers (empty by default)
    #
    # @return [HTTParty::Response]
    #
    def get(path, parameters = nil)
      options = {
        headers: headers,
        query: parameters
      }.compact

      response = self.class.get(path, options)
      handle_response(response)
    end

    #
    # Handle the HTTParty::Response. If an error occured, an exception will be
    # raised.
    #
    # @param [HTTParty] response The response received from the API
    #
    # @return [<Type>] <description>
    #
    # @raise [ServiceError] if an error occured from the API, for instance if
    # subscription_key is invalid.
    #
    # @raise [NetError] if the server has not been reached
    #
    def handle_response(response)
      case response.code
      when 200..299
        response
      else
        if response.request.format == :json
          raise ServiceError.new(
            code: response.code,
            message: response['code'] || response.message,
            azure_message: response['message'] || response.dig('error', 'message')
          )
        else
          raise NetError.new(
            code: response.code,
            message: response.message
          )
        end
      end
    end

    #
    # The header needed to make a request
    #
    # @return [Hash]
    #
    def headers
      {
        'Ocp-Apim-Subscription-Key' => subscription_key,
        'Content-Type' => 'application/json'
      }
    end
  end
end
