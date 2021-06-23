# frozen_string_literal: true

module AzureSTT
  module Models
    #
    # Model class for reports from a transcription.
    #
    class Report < Base
      #
      # The number of audio files that had been successsfully transcripted
      #
      # @!attribute [r] successful_transcriptions_count
      #   @return [Types::Coercible::Integer]
      attribute :successful_transcriptions_count, Types::Coercible::Integer

      #
      # The number of audio files that have failed
      #
      # @!attribute [r] failed_transcriptions_count
      #   @return [Types::Coercible::Integer]
      attribute :failed_transcriptions_count, Types::Coercible::Integer

      #
      # The details
      #
      # @!attribute [r] details
      #   @return [Types::Array.of(Types::Hash)]
      attribute :details, Types::Array.of(Types::Hash).default([].freeze)
    end
  end
end
