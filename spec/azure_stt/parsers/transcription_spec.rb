# frozen_string_literal: true

require 'spec_helper'

describe AzureSTT::Parsers::Transcription do
  subject(:parser) do
    described_class.new(transcription_hash)
  end

  let(:transcription_hash) do
    load_json('transcription.json')
  end

  describe '#attributes' do
    subject(:attributes) do
      parser.attributes
    end

    let(:client_hash) do
      {
        client: AzureSTT::Client.new(region: 'region', subscription_key: 'f')
      }
    end

    it 'returns a Hash' do
      expect(attributes).to be_an_instance_of Hash
    end

    it 'can create a AzureSTT::Transcription' do
      expect { AzureSTT::Transcription.new(attributes.merge(client_hash)) }
        .not_to raise_error
    end
  end
end
