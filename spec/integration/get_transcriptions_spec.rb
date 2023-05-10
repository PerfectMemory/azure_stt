# frozen_string_literal: true

require 'spec_helper'

# rubocop:disable RSpec/DescribeClass
describe 'Get a transcription', integration: true do
  before do
    AzureSTT.configure do |config|
      config.region = 'region'
      config.subscription_key = 'ljdhfkjfh'
    end
    AzureSTT.instance_variable_set(:@client, nil)
    stub_request(:get,
                 'https://region.api.cognitive.microsoft.com/speechtotext/v3.1/transcriptions')
      .to_return(response)
  end

  context 'when there is no error' do
    describe 'transcriptions' do
      subject(:transcriptions) do
        AzureSTT::Session.new.get_transcriptions
      end

      let(:response) do
        {
          headers:
          {
            'Content-Type' => 'application/json'
          },
          status: 200,
          body: read_fixture('transcriptions.json')
        }
      end

      it 'can create an array of transcripitons' do
        expect(transcriptions)
          .to all(be_an_instance_of(AzureSTT::Models::Transcription))
      end
    end
  end

  context 'with pagination' do
    describe 'transcriptions' do
      subject(:transcriptions) do
        AzureSTT::Session.new.get_transcriptions(skip: 10, top: 10)
      end

      let(:response) do
        {
          headers:
          {
            'Content-Type' => 'application/json'
          },
          status: 200,
          body: read_fixture('transcriptions.json')
        }
      end

      before do
        stub_request(:get,
                     'https://region.api.cognitive.microsoft.com/speechtotext/v3.1/transcriptions?skip=10&top=10')
          .to_return(response)
      end

      it 'can create an array of transcripitons' do
        expect(transcriptions)
          .to all(be_an_instance_of(AzureSTT::Models::Transcription))
      end
    end
  end

  context 'when there are no transcription' do
    describe 'transcriptions' do
      subject(:transcriptions) do
        AzureSTT::Session.new.get_transcriptions
      end

      let(:response) do
        {
          headers:
          {
            'Content-Type' => 'application/json'
          },
          status: 200,
          body: read_fixture('transcriptions_empty.json')
        }
      end

      it 'creates an empty array' do
        expect(transcriptions.size).to be 0
      end
    end
  end

  context 'when the api is unreachable (Error 500)' do
    describe 'transcriptions' do
      subject(:transcriptions) do
        AzureSTT::Session.new.get_transcriptions
      end

      let(:response) do
        {
          status: 500
        }
      end

      it 'raises a NetError' do
        expect { transcriptions }
          .to raise_error AzureSTT::NetError
      end
    end
  end

  context 'when there is a 400 error' do
    describe 'transcriptions' do
      subject(:transcriptions) do
        AzureSTT::Session.new.get_transcriptions
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
        expect { transcriptions }
          .to raise_error AzureSTT::ServiceError
      end
    end
  end
end
# rubocop:enable RSpec/DescribeClass
