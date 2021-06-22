# frozen_string_literal: true

require 'spec_helper'

describe AzureSTT do
  describe '#client' do
    subject(:client) do
      described_class.client
    end

    let(:subscription_key) do
      Faker::Alphanumeric.alphanumeric(number: 32)
    end

    before do
      described_class.instance_variable_set(:@client, nil)
      described_class.configure do |config|
        config.subscription_key = subscription_key
        config.region = 'uscentral'
      end
    end

    it 'returns an AzureSTT::Client' do
      expect(client).to be_an_instance_of AzureSTT::Client
    end

    it 'memoizes the client' do
      first_client = client
      expect(client).to be first_client
    end

    it 'has the correct region' do
      expect(client.region).to eq 'uscentral'
    end

    it 'has the correct subscription_key' do
      expect(client.subscription_key).to eq subscription_key
    end
  end

  describe '#configuration' do
    subject(:configuration) do
      described_class.configuration
    end

    it 'is an instance of AzureBatchTranscription::Configuration' do
      expect(configuration)
        .to be_an_instance_of AzureSTT::Configuration
    end

    it 'is memoized' do
      expect(configuration).to be described_class.configuration
    end
  end

  describe '#configure' do
    let(:subscription_key) do
      Faker::Alphanumeric.alphanumeric(number: 32)
    end

    it 'ables the user to configure the subscription key' do
      described_class.configure do |config|
        config.subscription_key = subscription_key
      end
      expect(described_class.configuration.subscription_key)
        .to eq subscription_key
    end
  end
end
