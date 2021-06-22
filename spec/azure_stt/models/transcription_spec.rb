# frozen_string_literal: true

require 'spec_helper'

describe AzureSTT::Models::Transcription do
  subject(:transcription) do
    build(:transcription)
  end

  context 'when the status is "Running"' do
    subject(:transcription_running) do
      transcription.new(status: 'Running')
    end

    its(:running?)      { is_expected.to be true  }
    its(:finished?)     { is_expected.to be false }
    its(:failed?)       { is_expected.to be false }
    its(:not_started?)  { is_expected.to be false }
    its(:succeeded?)    { is_expected.to be false }
  end

  context 'when the status is "Succeeded"' do
    subject(:transcription_succeded) do
      transcription.new(status: 'Succeeded')
    end

    its(:running?)      { is_expected.to be false }
    its(:finished?)     { is_expected.to be true  }
    its(:failed?)       { is_expected.to be false }
    its(:not_started?)  { is_expected.to be false }
    its(:succeeded?)    { is_expected.to be true  }
  end

  context 'when the status is "NotStarted"' do
    subject(:transcription_not_started) do
      transcription.new(status: 'NotStarted')
    end

    its(:running?)      { is_expected.to be false }
    its(:finished?)     { is_expected.to be false }
    its(:failed?)       { is_expected.to be false }
    its(:not_started?)  { is_expected.to be true  }
    its(:succeeded?)    { is_expected.to be false }
  end

  context 'when the status is "Failed"' do
    subject(:transcription_failed) do
      transcription.new(status: 'Failed')
    end

    its(:running?)      { is_expected.to be false }
    its(:finished?)     { is_expected.to be true  }
    its(:failed?)       { is_expected.to be true  }
    its(:not_started?)  { is_expected.to be false }
    its(:succeeded?)    { is_expected.to be false }
  end

  describe '#create' do
    subject(:create) do
      described_class.create(params)
    end

    let(:params) do
      {
        content_urls: ['whatever.ogg'],
        properties: {},
        locale: 'en-US',
        display_name: ''
      }
    end

    let(:params_client) do
      {
        contentUrls: params[:content_urls],
        properties: params[:properties],
        locale: params[:locale],
        displayName: params[:display_name]
      }
    end

    let(:transcription_hash) do
      load_json('transcription.json')
    end

    before do
      allow(AzureSTT.client)
        .to receive(:create_transcription)
        .with(params_client)
        .and_return(transcription_hash)
    end

    it 'calls the client' do
      create
      expect(AzureSTT.client)
        .to have_received(:create_transcription)
    end

    it 'can create a transcription using the parser' do
      expect(create).to be_an_instance_of described_class
    end
  end
end
