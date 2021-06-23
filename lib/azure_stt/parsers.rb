# frozen_string_literal: true

module AzureSTT
  #
  # Module for the parsers
  #
  module Parsers
  end
end

require_relative 'parsers/base'
require_relative 'parsers/transcription'
require_relative 'parsers/file'
require_relative 'parsers/report'
require_relative 'parsers/result'
require_relative 'parsers/combined_recognized_phrases'
require_relative 'parsers/recognized_phrase'
require_relative 'parsers/sentence'
require_relative 'parsers/word'
