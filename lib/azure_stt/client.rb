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
      self.class.base_uri "https://#{region}.api.cognitive.microsoft.com/speechtotext/v3.0"
    end

    #
    # Create a transcription for a batch or a single file.
    #
    # @see https://francecentral.dev.cognitive.microsoft.com/docs/services/speech-to-text-api-v3-0/operations/CreateTranscription
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

    private

    def post(path, body)
      puts body
      options = {
        headers: headers,
        body: body
      }

      response = self.class.post(path, options)
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
      puts response.inspect
      case response.code
      when 200..299
        response
      else
        if response.request.format == :json
          raise ServiceError.new(
            code: response['code'],
            message: response['message']
          )
        else
          raise NetError.new(
            code: response.code,
            message: response.response.message
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
