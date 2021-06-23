# frozen_string_literal: true

require 'spec_helper'

describe AzureSTT::Parsers::Result do
  subject(:parser) do
    described_class.new(result_hash)
  end

  let(:result_hash) do
    load_json('result.json')
  end

  describe '#attributes' do
    subject(:attributes) do
      parser.attributes
    end

    it 'returns a Hash' do
      expect(attributes).to be_an_instance_of Hash
    end

    it 'can create a AzureSTT::Models::Result' do
      expect { AzureSTT::Models::Result.new(attributes) }
        .not_to raise_error
    end
  end
end
