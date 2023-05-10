# azure_stt

[![Gem Version](https://badge.fury.io/rb/azure_stt.svg)](https://badge.fury.io/rb/azure_stt)
[![CI](https://github.com/PerfectMemory/azure_stt/actions/workflows/ci.yml/badge.svg)](https://github.com/PerfectMemory/azure_stt/actions/workflows/ci.yml)
[![Coverage Status](https://coveralls.io/repos/github/PerfectMemory/azure_stt/badge.svg)](https://coveralls.io/github/PerfectMemory/azure_stt)
[![Maintainability](https://api.codeclimate.com/v1/badges/375190d3122da56a9fe1/maintainability)](https://codeclimate.com/github/PerfectMemory/azure_stt/maintainability)

API Wrapper for the [Microsoft Azure Speech Services Speech-to-text REST API 3.1](https://docs.microsoft.com/en-us/azure/cognitive-services/speech-service/rest-speech-to-text) (Cognitive Services).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'azure_stt'
```

And then execute:

```bash
bundle
```

Or install it yourself as:

```bash
gem install azure_stt
```

## Azure Speech-to-text Subscription key

To be able to use the gem, you must have a subscription key.
You can generate one on your Azure account.

* If you don't have an Azure account, you can create one for free on [this page](https://azure.microsoft.com/en-us/free/).
* Once logged on your [Azure portal](https://portal.azure.com/), subscribe to Speech in Microsoft Cognitive Services.
* You will find two subscription keys available in 'RESOURCE MANAGEMENT > Keys' ('KEY 1' and 'KEY 2').

## Usage

### Configuration

Two environment variables are used:

- 'REGION': the region of your subscription

- 'SUBSCRIPTION_KEY': the API key you can generate on your Azure account.

You can look at the file `env.sample` and change the values.
If you do not want to use environment variables, you can configure the values like so:

```ruby
AzureSTT.configure do |config|
  config.region = 'your_region'
  config.subscription_key = 'your_key'
end
```

Finally, the class `AzureSTT::Session` uses by the default the values from the configuration, but you can initialize the session with custom values:

```ruby
session = AzureSTT::Session.new(region: 'your_region', subscription_key: 'your_key')
```

### Start a transcription

```ruby
require 'azure_stt'

properties = {
  "diarizationEnabled" => false,
  "wordLevelTimestampsEnabled" => false,
  "punctuationMode" => "DictatedAndAutomatic",
  "profanityFilterMode" => "Masked"
}

content_urls = [ 'https://path.com/audio.ogg', 'https://path.com/audio1.ogg']

session = AzureSTT::Session.new

transcription = session.create_transcription(
  content_urls: content_urls,
  properties: properties,
  locale: 'en-US',
  display_name: 'The name of the transcription')

# You can the retrieve the results of your transcription with the id
puts transcription.id
# Outputs 'your_transcription_id'

```

### Get a transcription

```ruby
require 'azure_stt'

session = AzureSTT::Session.new

transcription = session.get_transcription('your_transcription_id')

# Returns
# #<AzureSTT::Transcription id="d35a802d-70ae-4358-a35d-b5faa0c75457"
# # model="" properties={"diarizationEnabled"=>false,
# # "wordLevelTimestampsEnabled"=>false, "channels"=>[0, 1],
# # "punctuationMode"=>"DictatedAndAutomatic", "profanityFilterMode"=>"Masked",
# # "duration"=>"PT5M18S"}
# # links={"files"=>"https://uscentral.api.cognitive.microsoft.com/speechtotext/v3.1/transcriptions/d35a802d-70ae-4358-a35d-b5faa0c75457/files"}
# # last_action_date_time=#<Date: 2020-05-31 ((2459366j,0s,0n),+0s,2299161j)> created_date_time=#<Date: 2020-05-31 ((2459366j,0s,0n),+0s,2299161j)>
# # status="Succeeded" locale="en-US" display_name="Transcription name" files=[]>

if transcription.succeeded?
  # You can then access to the text, for instance :
  result = transcription.results.first
  puts result.text
end
```

### Delete a transcription

```ruby
require 'azure_stt'

session = AzureSTT::Session.new

transcription = session.delete_transcription('your_transcription_id')
```

The API doesn't seem to send 404 errors when the id is unknown, but always send a 204 response.
So the `Session#delete_transcription` returns `true` even when the transcription didn't exist.

### Starting a transcription, fetching the results and deleting the transcription

```ruby
require 'azure_stt'

session = AzureSTT::Session.new

properties = {
  "diarizationEnabled" => false,
  "wordLevelTimestampsEnabled" => false,
  "punctuationMode" => "DictatedAndAutomatic",
  "profanityFilterMode" => "Masked"
}

content_urls = [ 'https://path.com/audio.ogg' ]

session = AzureSTT::Session.new

transcription = session.create_transcription(
  content_urls: content_urls,
  properties: properties,
  locale: 'en-US',
  display_name: 'The name of the transcription')

id = transcription.id

while(!transcription.finished?) do
  sleep(30)
  transcription = session.get_transcription(id)
end

if(transcription.succeeded?)
  puts transcription.results.first.text
end

session.delete_transcription(id)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/PerfectMemory/azure_stt. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Code of Conduct

Everyone interacting in the AzureStt project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/PerfectMemory/azure_stt/blob/master/CODE_OF_CONDUCT.md).

