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

    its(:running?)      { should be true  }
    its(:finished?)     { should be false }
    its(:failed?)       { should be false }
    its(:not_started?)  { should be false }
    its(:succeeded?)    { should be false }
  end

  context 'when the status is "Succeeded"' do
    subject(:transcription_succeded) do
      transcription.new(status: 'Succeeded')
    end

    its(:running?)      { should be false }
    its(:finished?)     { should be true  }
    its(:failed?)       { should be false }
    its(:not_started?)  { should be false }
    its(:succeeded?)    { should be true  }
  end

  context 'when the status is "NotStarted"' do
    subject(:transcription_not_started) do
      transcription.new(status: 'NotStarted')
    end

    its(:running?)      { should be false }
    its(:finished?)     { should be false }
    its(:failed?)       { should be false }
    its(:not_started?)  { should be true  }
    its(:succeeded?)    { should be false }
  end

  context 'when the status is "Failed"' do
    subject(:transcription_failed) do
      transcription.new(status: 'Failed')
    end

    its(:running?)      { should be false }
    its(:finished?)     { should be true  }
    its(:failed?)       { should be true  }
    its(:not_started?)  { should be false }
    its(:succeeded?)    { should be false }
  end

  describe '#create' do
    subject(:create) do
      described_class.create(params)
    end

    let(:params) do
      {
        content_urls: [ 'whatever.ogg' ],
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
      load_json('create_transcription.json')
    end

    before do
      allow(AzureSTT.client)
        .to receive(:create_transcription)
        .with(params_client)
        .and_return(:transcription_hash)
    end

    it 'calls the client' do
      create
      expect(AzureSTT.client)
        .to have_received(:create_transcription)
    end
  end
end
