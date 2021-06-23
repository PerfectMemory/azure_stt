# frozen_string_literal: true

module AzureSTT
  module Models
    #
    # Model for a word. A word is optional in a sentence
    #
    class Word < Base
      attribute :word, Types::Coercible::String
      attribute? :offset, Types::Coercible::String
      attribute? :duration, Types::Coercible::String
      attribute? :offset_in_ticks, Types::Coercible::Integer
      attribute? :duration_in_ticks, Types::Coercible::Integer
      attribute :confidence, Types::Coercible::Float
    end
  end
end
