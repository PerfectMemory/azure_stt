# frozen_string_literal: true

module AzureSTT
  module Models
    #
    # Model to describe a sentence. A sentence is inside a nBest of a recognizedPhrase
    #
    class Sentence < Base
      attribute :confidence, Types::Coercible::Float
      attribute :lexical, Types::Coercible::String
      attribute :itn, Types::Coercible::String
      attribute :masked_itn, Types::Coercible::String
      attribute :display, Types::Coercible::String
      attribute? :words, Types::Aray.of(Word)
    end
  end
end
