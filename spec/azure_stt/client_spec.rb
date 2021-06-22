# frozen_string_literal: true

require 'spec_helper'

describe AzureSTT::Client do
  subject(:client) do
    described_class.new(region: 'region', subscription_key: 'ljdhfkjfh')
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

  describe '#create_transcription' do
    subject(:create_transcription) do
      client.create_transcription
    end

    before do
      stub_request(:post,
                   'https://region.api.cognitive.microsoft.com/speechtotext/v3.0/transcriptions')
        .to_return(response)
    end

    let(:json_response) do
      read_fixture('transcription.json')
    end

    it_behaves_like 'HTTP_errors_handler'

    it 'returns the correct parsed JSON' do
      expect(create_transcription).to eq(JSON.parse(json_response))
    end
  end

  describe '#get_transcription' do
    subject(:get_transcription) do
      client.get_transcription(id)
    end

    let(:id) do
      '9c142230-a9e4-4dbb-8cc7-70ca43d5cc91'
    end

    let(:json_response) do
      read_fixture('transcription.json')
    end

    before do
      stub_request(:get,
                   "https://region.api.cognitive.microsoft.com/speechtotext/v3.0/transcriptions/#{id}")
        .to_return(response)
    end

    it_behaves_like 'HTTP_errors_handler'

    it 'returns the correct parsed JSON' do
      expect(get_transcription).to eq(JSON.parse(json_response))
    end
  end

  describe '#get_transcriptions' do
    subject(:get_transcriptions) do
      client.get_transcriptions
    end

    let(:json_response) do
      read_fixture('transcriptions.json')
    end

    before do
      stub_request(:get,
                   'https://region.api.cognitive.microsoft.com/speechtotext/v3.0/transcriptions')
        .to_return(response)
    end

    it_behaves_like 'HTTP_errors_handler'

    it 'returns the correct parsed JSON' do
      expect(get_transcriptions).to eq(JSON.parse(json_response)['values'])
    end
  end

  describe '#get_transcriptions_files' do
    subject(:get_transcription_files) do
      client.get_transcription_files(id)
    end

    let(:id) do
      '9c142230-a9e4-4dbb-8cc7-70ca43d5cc91'
    end

    let(:json_response) do
      read_fixture('files.json')
    end

    before do
      stub_request(:get,
                   "https://region.api.cognitive.microsoft.com/speechtotext/v3.0/transcriptions/#{id}/files")
        .to_return(response)
    end

    it_behaves_like 'HTTP_errors_handler'

    it 'returns the correct parsed JSON' do
      expect(get_transcription_files).to eq(JSON.parse(json_response)['values'])
    end
  end

  describe '#get_file' do
    subject(:get_file) do
      client.get_file(url)
    end

    let(:url) do
      'https://path.json'
    end

    let(:json_response) do
      read_fixture('report.json')
    end

    before do
      stub_request(:get, url).to_return(response)
    end

    it_behaves_like 'HTTP_errors_handler'

    it 'returns the correct parsed JSON' do
      expect(get_file).to eq(JSON.parse(json_response))
    end
  end
end
