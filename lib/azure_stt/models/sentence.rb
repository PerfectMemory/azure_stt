# frozen_string_literal: true

module AzureSTT
  module Models
    #
    # Model to describe a sentence. A sentence is inside a nBest of a recognizedPhrase
    #
    class Sentence < Base
      #
      # The confidence score of the transcripted sentence.
      #
      # @!attribute [r] confidence
      #   @return [Types::Coercible::Float]
      attribute :confidence, Types::Coercible::Float

      #
      # The lexical field
      #
      # @!attribute [r] lexical
      #   @return [Types::Coercible::String]
      attribute :lexical, Types::Coercible::String

      #
      # The itn field
      #
      # @!attribute [r] itn
      #   @return [Types::Coercible::String]
      attribute :itn, Types::Coercible::String

      #
      # The maskedITN field
      #
      # @!attribute [r] masked_itn
      #   @return [Types::Coercible::String]
      attribute :masked_itn, Types::Coercible::String

      #
      # The display field. Displays the text with the format you specified in
      # the paramters of the transcription.
      #
      # @!attribute [r] transcript
      #   @return [Types::Coercible::String]
      attribute :transcript, Types::Coercible::String

      #
      # The words recognized in the sentence.
      #
      # @!attribute [r] words
      #   @return [Types::Array.of(Word)]
      attribute? :words, Types::Array.of(Word).default([].freeze)
    end
  end
end
