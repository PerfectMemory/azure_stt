# frozen_string_literal: true

require 'spec_helper'

describe AzureSTT::Parsers::Report do
  subject(:parser) do
    described_class.new(report_hash)
  end

  let(:report_hash) do
    load_json('report.json')
  end

  describe '#attributes' do
    subject(:attributes) do
      parser.attributes
    end

    it 'returns a Hash' do
      expect(attributes).to be_an_instance_of Hash
    end

    it 'can create a AzureSTT::Models::Report' do
      expect { AzureSTT::Models::Report.new(attributes) }
        .not_to raise_error
    end
  end
end
