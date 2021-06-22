# frozen_string_literal: true

require 'securerandom'

FactoryBot.define do
  factory :transcription, class: 'AzureSTT::Models::Transcription' do
    id { SecureRandom.uuid }
    model do
      "https://region.api.cognitive.microsoft.com/speechtotext/v3.0/models/base/#{SecureRandom.uuid}"
    end
    links do
      {
        files: "https://region.api.cognitive.microsoft.com/speechtotext/v3.0/transcriptions/#{id}/files"
      }
    end
    properties do
      {
        diarizationEnabled: false,
        wordLevelTimestampsEnabled: false,
        punctuationMode: 'DictatedAndAutomatic',
        profanityFilterMode: 'Masked'
      }
    end
    last_action_date_time { Faker::Date.in_date_period }
    created_date_time { Faker::Date.in_date_period }
    status { 'Succeeded' }
    locale { 'en-US' }
    display_name { '' }

    initialize_with { new(attributes) }
  end
end
