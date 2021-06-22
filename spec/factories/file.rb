# frozen_string_literal: true

FactoryBot.define do
  factory :file, class: 'AzureSTT::Models::File' do
    id { SecureRandom.uuid }
    name { 'Name' }
    kind { 'Transcription' }
    properties { { size: 200 } }
    created_date_time { Faker::Date.in_date_period }
    content_url { 'https://link_to_the_file.com/file.json' }

    initialize_with { new(attributes) }
  end
end
