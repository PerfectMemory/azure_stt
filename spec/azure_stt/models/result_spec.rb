# frozen_string_literal: true

require 'spec_helper'

describe AzureSTT::Models::Result do
  subject(:result) do
    described_class.new(AzureSTT::Parsers::Result.new(result_json).attributes)
  end

  let(:result_json) do
    load_json('result.json')
  end

  describe '#text' do
    subject(:text) do
      result.text
    end

    it 'returns the expected value' do
      expect(text)
        .to eq(result_json.dig('combinedRecognizedPhrases', 0, 'display'))
    end
  end

  describe '#sentences' do
    subject(:sentences) do
      result.sentences
    end

    it 'returns an array sentences' do
      expect(sentences).to all(be_an_instance_of(AzureSTT::Models::Sentence))
    end

    it 'has the correct size' do
      expect(sentences.size)
        .to eq(result_json['recognizedPhrases'].size)
    end
  end
end
