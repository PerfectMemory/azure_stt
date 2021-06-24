# frozen_string_literal: true

require 'spec_helper'

describe AzureSTT::Models::File do
  subject(:file) do
    described_class.new(attributes)
  end

  let(:attributes) do
    AzureSTT::Parsers::File.new(file_hash).attributes.merge({ client: client })
  end

  let(:file_hash) do
    load_json('file.json')
  end

  let(:client) do
    AzureSTT::Client.new(region: 'region', subscription_key: 'dfdlhgf')
  end

  describe '#content' do
    subject(:content) do
      file.content
    end

    before do
      allow(client).to receive(:get_file).and_return(result_hash)
    end

    let(:result_hash) do
      load_json('result.json')
    end

    it 'calls the client' do
      content
      expect(client).to have_received(:get_file)
    end

    it 'does nothing on the hash' do
      expect(content).to eq result_hash
    end
  end
end
