# frozen_string_literal: true

require 'spec_helper'

describe AzureSTT::Transcription do
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
    its(:succeeded?)    { is_expected.to be false }
  end

  context 'when the status is "Succeeded"' do
    subject(:transcription_succeded) do
      transcription.new(status: 'Succeeded')
    end

    its(:running?)      { is_expected.to be false }
    its(:finished?)     { is_expected.to be true  }
    its(:failed?)       { is_expected.to be false }
    its(:succeeded?)    { is_expected.to be true  }
  end

  context 'when the status is "NotStarted"' do
    subject(:transcription_not_started) do
      transcription.new(status: 'NotStarted')
    end

    its(:running?)      { is_expected.to be false }
    its(:finished?)     { is_expected.to be false }
    its(:failed?)       { is_expected.to be false }
    its(:succeeded?)    { is_expected.to be false }
  end

  context 'when the status is "Failed"' do
    subject(:transcription_failed) do
      transcription.new(status: 'Failed')
    end

    its(:running?)      { is_expected.to be false }
    its(:finished?)     { is_expected.to be true  }
    its(:failed?)       { is_expected.to be true  }
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

  describe '#get' do
    subject(:get) do
      described_class.get(id)
    end

    let(:id) do
      '9c142230-a9e4-4dbb-8cc7-70ca43d5cc91'
    end

    let(:transcription_hash) do
      load_json('transcription.json')
    end

    before do
      allow(AzureSTT.client)
        .to receive(:get_transcription)
        .with(id)
        .and_return(transcription_hash)
    end

    it 'calls the client' do
      get
      expect(AzureSTT.client)
        .to have_received(:get_transcription)
    end

    it 'can create a transcription using the parser' do
      expect(get).to be_an_instance_of described_class
    end
  end

  describe '#get_multiple' do
    subject(:get_multiple) do
      described_class.get_multiple
    end

    let(:transcriptions_array) do
      load_json('transcriptions.json')['values']
    end

    before do
      allow(AzureSTT.client)
        .to receive(:get_transcriptions)
        .and_return(transcriptions_array)
    end

    it 'calls the client' do
      get_multiple
      expect(AzureSTT.client)
        .to have_received(:get_transcriptions)
    end

    it 'returns an array' do
      expect(get_multiple).to be_an_instance_of Array
    end

    it 'contains instances of AzureSTT::Transcription' do
      expect(get_multiple)
        .to all(be_an_instance_of(described_class))
    end
  end

  describe '#refresh!' do
    subject(:refresh) do
      transcription.refresh!
    end

    let(:transcription_hash) do
      load_json('transcription.json')
    end

    before do
      allow(AzureSTT.client)
        .to receive(:get_transcription)
        .with(transcription.id)
        .and_return(transcription_hash)
    end

    it 'calls the client' do
      refresh
      expect(AzureSTT.client)
        .to have_received(:get_transcription)
    end

    it 'updates the attributes' do
      expect do
        refresh
      end.to change(transcription, :last_action_date_time)
        .to(Date.parse('"2019-01-07T11:36:07Z"'))
    end
  end

  describe '#report' do
    subject(:report) do
      transcription.report
    end

    let(:files_array) do
      load_json('files.json')['values']
    end

    let(:report_hash) do
      load_json('report.json')
    end

    before do
      allow(AzureSTT.client)
        .to receive(:get_transcription_files)
        .with(transcription.id)
        .and_return(files_array)
      allow(AzureSTT.client)
        .to receive(:get_file)
        .with('https://path.json')
        .and_return(report_hash)
    end

    it 'calls the client' do
      report
      expect(AzureSTT.client)
        .to have_received(:get_transcription_files)
    end

    it 'returns a AzureSTT::Models::Client' do
      expect(report).to be_an_instance_of(AzureSTT::Models::Report)
    end
  end

  describe '#results' do
    subject(:results) do
      transcription.results
    end

    let(:files_array) do
      load_json('files.json')['values']
    end

    let(:result_hash) do
      load_json('result.json')
    end

    before do
      allow(AzureSTT.client)
        .to receive(:get_transcription_files)
        .with(transcription.id)
        .and_return(files_array)
      allow(AzureSTT.client)
        .to receive(:get_file)
        .with('https://path1.json')
        .and_return(result_hash)
    end

    it 'calls the client to have the files' do
      results
      expect(AzureSTT.client)
        .to have_received(:get_transcription_files)
    end

    it 'calls the client to get the results' do
      results
      expect(AzureSTT.client)
        .to have_received(:get_file)
    end

    it 'returns a AzureSTT::Models::Client' do
      expect(results).to all(be_an_instance_of(AzureSTT::Models::Result))
    end
  end
end
