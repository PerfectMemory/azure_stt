# frozen_string_literal: true

require 'spec_helper'

# rubocop:disable RSpec/DescribeClass
describe 'Delete a transcription', integration: true do
  before do
    AzureSTT.configure do |config|
      config.region = 'region'
      config.subscription_key = 'ljdhfkjfh'
    end
    AzureSTT.instance_variable_set(:@client, nil)
    stub_request(:delete,
                 "https://region.api.cognitive.microsoft.com/speechtotext/v3.0/transcriptions/#{id}")
      .to_return(response)
  end

  let(:id) do
    'sfhdskfhd-dsgfd44545-fsddf'
  end

  context 'when there is no error' do
    subject(:delete_transcription) do
      AzureSTT::Session.new.delete_transcription(id)
    end

    let(:response) do
      {
        status: 204
      }
    end

    it 'returns true' do
      expect(delete_transcription).to be_truthy
    end
  end

  context 'when the api is unreachable (Error 500)' do
    subject(:delete_transcription) do
      AzureSTT::Session.new.delete_transcription(id)
    end

    let(:response) do
      {
        status: 500
      }
    end

    it 'raises a NetError' do
      expect { delete_transcription }
        .to raise_error AzureSTT::NetError
    end
  end

  context 'when there is a 400 error' do
    subject(:delete_transcription) do
      AzureSTT::Session.new.delete_transcription(id)
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
      expect { delete_transcription }
        .to raise_error AzureSTT::ServiceError
    end
  end
end
# rubocop:enable RSpec/DescribeClass
