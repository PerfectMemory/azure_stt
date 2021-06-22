# frozen_string_literal: true

require 'spec_helper'

describe 'Create a transcription', integration: true do
  let(:arguments) do
    {
      content_urls: ['whatever.com/sample.ogg'],
      properties: {
        'diarizationEnabled' => false,
        'wordLevelTimestampsEnabled' => false,
        'punctuationMode' => 'DictatedAndAutomatic',
        'profanityFilterMode' => 'Masked'
      },
      locale: 'en-US',
      display_name: 'whatever'
    }
  end

  before do
    AzureSTT.configure do |config|
      config.region = 'region'
      config.subscription_key = 'ljdhfkjfh'
    end
    AzureSTT.instance_variable_set(:@client, nil)
    stub_request(:post,
                 'https://region.api.cognitive.microsoft.com/speechtotext/v3.0/transcriptions')
      .to_return(response)
  end

  context 'when there is no error' do
    describe 'transcription' do
      subject(:transcription) do
        AzureSTT::Models::Transcription.create(arguments)
      end

      let(:response) do
        {
          headers:
          {
            'Content-Type' => 'application/json'
          },
          status: 201,
          body: read_fixture('create_transcription.json')
        }
      end

      it 'can create a transcription' do
        expect(transcription)
          .to be_an_instance_of(AzureSTT::Models::Transcription)
      end

      it 'has the correct id' do
        expect(transcription.id).to eq '9c142230-a9e4-4dbb-8cc7-70ca43d5cc91'
      end

      it 'has the correct status' do
        expect(transcription.succeeded?).to be true
      end
    end
  end

  context 'when the api is unreachable (Error 500)' do
    describe 'transcription' do
      subject(:transcription) do
        AzureSTT::Models::Transcription.create(arguments)
      end

      let(:response) do
        {
          status: 500
        }
      end

      it 'raises a NetError' do
        expect { transcription }
          .to raise_error AzureSTT::NetError
      end
    end
  end

  context 'when there is a 400 error' do
    describe 'transcription' do
      subject(:transcription) do
        AzureSTT::Models::Transcription.create(arguments)
      end

      let(:response) do
        {
          status: 400,
          headers:
          {
            'Content-Type' => 'application/json'
          },
          body: read_fixture('error_401.json')
        }
      end

      it 'raises a ServiceError' do
        expect { transcription }
          .to raise_error AzureSTT::ServiceError
      end
    end
  end
end
