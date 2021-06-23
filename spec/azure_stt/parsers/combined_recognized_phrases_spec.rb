# frozen_string_literal: true

require 'spec_helper'

describe AzureSTT::Parsers::CombinedRecognizedPhrases do
  subject(:parser) do
    described_class.new(combined_recognized_phrases_hash)
  end

  let(:combined_recognized_phrases_hash) do
    load_json('combined_recognized_phrases.json')
  end

  describe '#attributes' do
    subject(:attributes) do
      parser.attributes
    end

    it 'returns a Hash' do
      expect(attributes).to be_an_instance_of Hash
    end

    it 'can create a AzureSTT::Models::CombinedRecognizedPhrases' do
      expect { AzureSTT::Models::CombinedRecognizedPhrases.new(attributes) }
        .not_to raise_error
    end
  end
end
