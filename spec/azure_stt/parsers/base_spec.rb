# frozen_string_literal: true

require 'spec_helper'

describe AzureSTT::Parsers::Base do
  subject(:parser) do
    described_class.new(hash)
  end

  let(:hash) do
    {}
  end

  describe '#initialize' do
    it 'initializes the hash attribute' do
      expect(parser.hash).to eq hash
    end
  end

  describe '#attributes' do
    it 'raises a NoMethodError with a understandable message' do
      expect { parser.attributes }
        .to raise_error(NoMethodError, /Implement method/)
    end
  end
end
