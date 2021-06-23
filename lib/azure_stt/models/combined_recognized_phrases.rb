# frozen_string_literal: true

module AzureSTT
  module Models
    #
    # Model class for the combinedRecognizedPhrases field in the results of
    # the transcriptions
    #
    class CombinedRecognizedPhrases < Base
      #
      # The channel of the combination. The API supports only two channels, so
      # it is 0 or 1
      #
      # @!attribute [r] channel
      #   @return [Types::Coercible::Integer]
      attribute :channel, Types::Coercible::Integer

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
    end
  end
end
