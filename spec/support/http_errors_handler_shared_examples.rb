# frozen_string_literal: true

require 'spec_helper'

shared_examples 'HTTP_errors_handler' do
  context 'when there is a network error' do
    let(:response) do
      {
        status: 500
      }
    end

    it 'raises a NetError' do
      expect { subject }
        .to raise_error AzureSTT::NetError
    end
  end

  context 'when there is an error on the API side' do
    let(:response) do
      {
        status: 400,
        headers:
        {
          'Content-Type' => 'application/json'
        },
        body: json_response
      }
    end

    it 'raises a ServiceError' do
      expect { subject }
        .to raise_error AzureSTT::ServiceError
    end
  end
end
