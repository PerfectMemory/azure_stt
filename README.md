# azure_stt
API Wrapper for the [Microsoft Azure Speech Services Speech-to-text REST API 3.0](https://docs.microsoft.com/en-us/azure/cognitive-services/speech-service/rest-speech-to-text) (Cognitive Services).

## Usage

### Get a transcription

```ruby
require 'azure_stt'

# By default, the variables are fetch from ENV['SUBSCRIPTION_KEY] and ENV['REGION']
AzureSTT.configure do |config|
  config.subscription_key = 'your_subscription_key'
  config.region = 'your_region'
end

t = AzureSTT::Transcription.get('d35a802d-70ae-4358-a35d-b5faa0c75457')

# Returns
# #<AzureSTT::Transcription id="d35a802d-70ae-4358-a35d-b5faa0c75457"
# # model="" properties={"diarizationEnabled"=>false,
# # "wordLevelTimestampsEnabled"=>false, "channels"=>[0, 1],
# # "punctuationMode"=>"DictatedAndAutomatic", "profanityFilterMode"=>"Masked",
# # "duration"=>"PT5M18S"}
# # links={"files"=>"https://uscentral.api.cognitive.microsoft.com/speechtotext/v3.0/transcriptions/d35a802d-70ae-4358-a35d-b5faa0c75457/files"}
# # last_action_date_time=#<Date: 2020-05-31 ((2459366j,0s,0n),+0s,2299161j)> created_date_time=#<Date: 2020-05-31 ((2459366j,0s,0n),+0s,2299161j)>
# # status="Succeeded" locale="en-US" display_name="Transcription name" files=[]>

# You can then access to the text, for instance :
result = t.results.first
puts result.combined_recognized_phrases.display
```
