# frozen_string_literal: true

require 'spec_helper'

describe AzureSTT::Parsers::File do
  subject(:parser) do
    described_class.new(file_hash)
  end

  let(:file_hash) do
    load_json('file.json')
  end

  let(:client) do
    AzureSTT::Client.new(region: 'region', subscription_key: 'dkjsdhfk')
  end

  describe '#attributes' do
    subject(:attributes) do
      parser.attributes
    end

    it 'returns a Hash' do
      expect(attributes).to be_an_instance_of Hash
    end

    it 'can create a AzureSTT::Models::File' do
      expect { AzureSTT::Models::File.new(attributes.merge({ client: client })) }
        .not_to raise_error
    end
  end
end
