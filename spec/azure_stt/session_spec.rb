# frozen_string_literal: true

require 'spec_helper'

describe AzureSTT::Session do
  subject(:session) do
    described_class.new
  end

  let(:client) do
    AzureSTT::Client.new(region: 'region', subscription_key: 'dfhd')
  end

  before do
    allow(AzureSTT::Client)
      .to receive(:new)
      .and_return(client)
  end

  describe '#create_transcription' do
    subject(:create_transcription) do
      session.create_transcription(params)
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
      allow(client)
        .to receive(:create_transcription)
        .with(params_client)
        .and_return(transcription_hash)
    end

    it 'calls the client' do
      create_transcription
      expect(client)
        .to have_received(:create_transcription)
    end

    it 'can create a transcription using the parser' do
      expect(create_transcription)
        .to be_an_instance_of AzureSTT::Models::Transcription
    end
  end

  describe '#get_transcription' do
    subject(:get_transcription) do
      session.get_transcription(id)
    end

    let(:id) do
      '9c142230-a9e4-4dbb-8cc7-70ca43d5cc91'
    end

    let(:transcription_hash) do
      load_json('transcription.json')
    end

    before do
      allow(client)
        .to receive(:get_transcription)
        .with(id)
        .and_return(transcription_hash)
    end

    it 'calls the client' do
      get_transcription
      expect(client)
        .to have_received(:get_transcription)
    end

    it 'can create a transcription using the parser' do
      expect(get_transcription)
        .to be_an_instance_of AzureSTT::Models::Transcription
    end
  end

  describe '#get_transcriptions' do
    subject(:get_transcriptions) do
      session.get_transcriptions
    end

    let(:transcriptions_array) do
      load_json('transcriptions.json')['values']
    end

    before do
      allow(client)
        .to receive(:get_transcriptions)
        .and_return(transcriptions_array)
    end

    it 'calls the client' do
      get_transcriptions
      expect(client)
        .to have_received(:get_transcriptions)
    end

    it 'returns an array' do
      expect(get_transcriptions).to be_an_instance_of Array
    end

    it 'contains instances of AzureSTT::Models::Transcription' do
      expect(get_transcriptions)
        .to all(be_an_instance_of(AzureSTT::Models::Transcription))
    end
  end

  describe '#delete_transcription' do
    let(:delete_transcription) do
      session.delete_transcription(id)
    end

    let(:id) do
      '9c142230-a9e4-4dbb-8cc7-70ca43d5cc91'
    end

    before do
      allow(client)
        .to receive(:delete_transcription)
        .with(id)
        .and_return(true)
    end

    it 'calls the client' do
      delete_transcription
      expect(client)
        .to have_received(:delete_transcription)
        .with(id)
    end

    it 'returns true' do
      expect(delete_transcription).to be_truthy
    end
  end
end
