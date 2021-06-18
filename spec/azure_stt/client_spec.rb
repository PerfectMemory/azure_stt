# frozen_string_literal: true

require 'spec_helper'

describe AzureSTT::Client do
  subject(:client) do
    described_class.new(region: 'region')
  end

  let(:arguments) do
    {
      'contentUrls' => ['whatever.com/sample.ogg'],
      'properties' => {
        'diarizationEnabled' => false,
        'wordLevelTimestampsEnabled' => false,
        'punctuationMode' => 'DictatedAndAutomatic',
        'profanityFilterMode' => 'Masked'
      },
      'locale' => 'en-US',
      'displayName' => 'whatever'
    }
  end

  describe '#create_transcription' do
    subject(:create_transcription) do
      client.create_transcription
    end

    before do
      stub_request(:post,
                   'https://region.api.cognitive.microsoft.com/speechtotext/v3.0/transcriptions'
                  )
        .to_return(response)
    end

    let(:response) do
      {
        status: 201,
        headers:
        {
          'Content-Type' => 'application/json'
        },
        body: json_response
      }
    end

    let(:json_response) do
      read_fixture('create_transcription.json')
    end

    it 'returns the correct JSON' do
      expect(create_transcription).to eq(JSON.parse(json_response))
    end

    context 'when there is a network error' do
      let(:response) do
        {
          status: 500
        }
      end

      it 'raises a NetError' do
        expect { create_transcription }
          .to raise_error AzureSTT::NetError
      end
    end

    context 'when there is an error on the API side' do
      let(:response) do
        {
          status: 400,
          headers:
          {
            'Content-Type' => 'application/json'
          },
          body: json_response
        }
      end

      it 'raises a ServiceError' do
        expect { create_transcription }
          .to raise_error AzureSTT::ServiceError
      end
    end
  end
end
