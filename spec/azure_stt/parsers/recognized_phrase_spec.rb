# frozen_string_literal: true

require 'spec_helper'

describe AzureSTT::Parsers::RecognizedPhrase do
  describe '#attributes' do
    context 'when there is no speaker' do
      subject(:attributes) do
        described_class.new(no_speaker_hash).attributes
      end

      let(:no_speaker_hash) do
        load_json('recognized_phrase_no_speaker.json')
      end

      it 'returns a Hash' do
        expect(attributes).to be_an_instance_of Hash
      end

      it 'can create a AzureSTT::Models::RecognizedPhrase' do
        expect { AzureSTT::Models::RecognizedPhrase.new(attributes) }
          .not_to raise_error
      end
    end
  end

  context 'when there is a speaker' do
    subject(:attributes) do
      described_class.new(with_speaker_hash).attributes
    end

    let(:with_speaker_hash) do
      load_json('recognized_phrase.json')
    end

    it 'returns a Hash' do
      expect(attributes).to be_an_instance_of Hash
    end

    it 'can create a AzureSTT::Models::RecognizedPhrase' do
      expect { AzureSTT::Models::RecognizedPhrase.new(attributes) }
        .not_to raise_error
    end
  end
end
