# frozen_string_literal: true

module AzureSTT
  module Models
    #
    # Model class to store a recognized phrase from the results file
    #
    class RecognizedPhrase < Base
      #
      # The status of the recognition for this phrase
      #
      # @!attribute [r] recognition_status
      #   @return [Types::Coercible::String]
      attribute :recognition_status, Types::Coercible::String

      #
      # The channel of the phrase. The API supports only two channels, so
      # it is 0 or 1
      #
      # @!attribute [r] channel
      #   @return [Types::Coercible::Integer]
      attribute :channel, Types::Coercible::Integer

      #
      # The speaker. The API supports only two speakers, so it is 0 or 1
      #
      # @!attribute [r] speaker
      #   @return [Types::Coercible::Integer]
      attribute? :speaker, Types::Coercible::Integer

      #
      # The offset of the phrase in the audio. Ex: 'PT0.13S' means that the
      # phrase begins at 13 seconds on the audio file
      #
      # @!attribute [r] offset
      #   @return [Types::Coercible::String]
      attribute? :offset, Types::Coercible::String

      #
      # The duration of the phrase. Ex: 'PT0.13S' means that the phrase lasts 13
      # seconds
      #
      # @!attribute [r] duration
      #   @return [Types::Coercible::String]
      attribute? :duration, Types::Coercible::String

      #
      # The offset of the phrase in the audio in ticks.
      #
      # @!attribute [r] offset_in_ticks
      #   @return [Types::Coercible::Integer]
      attribute? :offset_in_ticks, Types::Coercible::Integer

      #
      # The duration of the phrase in ticks
      #
      # @!attribute [r] duration_in_ticks
      #   @return [Types::Coercible::Integer]
      attribute? :duration_in_ticks, Types::Coercible::Integer

      #
      # The sentences the API recognized. The first is the sentence with the
      # highest confidence.
      #
      # @!attribute [r] n_best
      #   @return [Types::Array.of(Sentence)]
      attribute :n_best, Types::Array.of(Sentence).default([].freeze)
    end
  end
end
