# frozen_string_literal: true

require 'spec_helper'

shared_examples 'HTTP_errors_handler' do
  context 'when there is a network error' do
    let(:response) do
      {
        status: [500, 'Internal Server Error']
      }
    end

    it 'raises a NetError' do
      expect { subject }
        .to raise_error(AzureSTT::NetError, 'Internal Server Error (500)')
    end
  end

  context 'when there is an error on the API side' do
    let(:response) do
      {
        status: [401, 'PermissionDenied'],
        headers:
        {
          'Content-Type' => 'application/json'
        },
        body: read_fixture('error_401.json')
      }
    end

    let(:expected_message) do
      "PermissionDenied (401): #{load_json('error_401.json').dig('error', 'message')}"
    end

    it 'raises a ServiceError' do
      expect { subject }
        .to raise_error(AzureSTT::ServiceError, expected_message)
    end
  end
end
