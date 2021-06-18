# frozen_string_literal: true

require 'spec_helper'

describe AzureSTT do
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
