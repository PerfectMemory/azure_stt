# frozen_string_literal: true

require 'spec_helper'

# rubocop:disable RSpec/DescribeClass
describe 'get the result of a transcription', integration: true do
  before do
    AzureSTT.configure do |config|
      config.region = 'region'
      config.subscription_key = 'ljdhfkjfh'
    end
    stub_request(:get,
                 "https://region.api.cognitive.microsoft.com/speechtotext/v3.1/transcriptions/#{id}")
      .to_return(get_transcription_response)
    stub_request(:get,
                 "https://region.api.cognitive.microsoft.com/speechtotext/v3.1/transcriptions/#{id}/files")
      .to_return(get_files_response)
    stub_request(:get,
                 'https://path1.json')
      .to_return(get_result)
  end

  let(:id) do
    '9c142230-a9e4-4dbb-8cc7-70ca43d5cc91'
  end

  let(:get_transcription_response) do
    {
      headers:
      {
        'Content-Type' => 'application/json'
      },
      status: 200,
      body: read_fixture('transcription.json')
    }
  end

  let(:get_files_response) do
    {
      headers:
      {
        'Content-Type' => 'application/json'
      },
      status: 200,
      body: read_fixture('files.json')
    }
  end

  let(:get_result) do
    {
      headers:
      {
        'Content-Type' => 'application/json'
      },
      status: 200,
      body: read_fixture('result.json')
    }
  end

  it 'can get the result file and instantiate it' do
    transcription = AzureSTT::Session.new.get_transcription(id)
    expect(transcription.results.first)
      .to be_an_instance_of(AzureSTT::Models::Result)
  end
end
# rubocop:enable RSpec/DescribeClass
