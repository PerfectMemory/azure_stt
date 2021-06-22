# frozen_string_literal: true

module AzureSTT
  module Models
    #
    # Model class for reports from a transcription.
    #
    class Report < Base
      attribute :successful_transcriptions_count, Types::Coercible::Integer
      attribute :failed_transcriptions_count, Types::Coercible::Integer
      attribute :details, Types::Array.of(Types::Hash).default([].freeze)
    end
  end
end
