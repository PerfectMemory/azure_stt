# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'azure_stt/version'

Gem::Specification.new do |spec|
  spec.name          = 'azure_stt'
  spec.version       = AzureStt::VERSION
  spec.authors       = ['François Pouly']
  spec.email         = ['francois.pouly@perfect-memory.com']

  spec.summary       = 'API Wrapper for the Microsoft Translator Text API 3.0'
  spec.description   = 'API Wrapper for the Microsoft Translator Text API 3.0 (Cognitive Services)'
  spec.homepage      = 'https://github.com/PerfectMemory/azure_stt'
  spec.license       = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.6'
  spec.add_dependency 'dry_struct', '~> 1'
  spec.add_dependency 'httparty', '~> 0.17'
end
