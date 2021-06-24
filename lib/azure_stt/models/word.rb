# frozen_string_literal: true

module AzureSTT
  module Models
    #
    # Model for a word. A word is optional in a sentence
    #
    class Word < Base
      #
      # The word
      #
      # @!attribute [r] word
      #   @return [Types::Coercible::String]
      attribute :word, Types::Coercible::String

      #
      # The offset of the word in the audio. Ex: 'PT0.13S' means that the
      # phrase begins at 13 seconds on the audio file
      #
      # @!attribute [r] offset
      #   @return [Types::Coercible::String]
      attribute? :offset, Types::Coercible::String

      #
      # The duration of the word. Ex: 'PT0.13S' means that the phrase lasts 13
      # seconds
      #
      # @!attribute [r] duration
      #   @return [Types::Coercible::String]
      attribute? :duration, Types::Coercible::String

      #
      # The offset of the word in the audio in ticks.
      #
      # @!attribute [r] offset_in_ticks
      #   @return [Types::Coercible::Integer]
      attribute? :offset_in_ticks, Types::Coercible::Integer

      #
      # The duration of the word in ticks
      #
      # @!attribute [r] duration_in_ticks
      #   @return [Types::Coercible::Integer]
      attribute? :duration_in_ticks, Types::Coercible::Integer

      #
      # The confidence score of the transcripted word.
      #
      # @!attribute [r] confidence
      #   @return [Types::Coercible::Float]
      attribute :confidence, Types::Coercible::Float
    end
  end
end
