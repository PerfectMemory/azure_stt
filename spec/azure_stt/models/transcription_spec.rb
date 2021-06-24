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
      allow(transcription.client)
        .to receive(:get_transcription_files)
        .with(transcription.id)
        .and_return(files_array)
      allow(transcription.client)
        .to receive(:get_file)
        .with('https://path.json')
        .and_return(report_hash)
    end

    it 'calls the client' do
      report
      expect(transcription.client)
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
      allow(transcription.client)
        .to receive(:get_transcription_files)
        .with(transcription.id)
        .and_return(files_array)
      allow(transcription.client)
        .to receive(:get_file)
        .with('https://path1.json')
        .and_return(result_hash)
    end

    it 'calls the client to have the files' do
      results
      expect(transcription.client)
        .to have_received(:get_transcription_files)
    end

    it 'calls the client to get the results' do
      results
      expect(transcription.client)
        .to have_received(:get_file)
    end

    it 'returns a AzureSTT::Models::Client' do
      expect(results).to all(be_an_instance_of(AzureSTT::Models::Result))
    end
  end
end
