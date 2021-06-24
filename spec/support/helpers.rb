# frozen_string_literal: true

module Helpers
  def fixture_path(*path)
    File.join(File.dirname(__FILE__), '..', 'etc', path)
  end

  def read_fixture(*path)
    File.read(fixture_path(*path))
  end

  def load_json(*path)
    JSON.parse(File.read(fixture_path(*path)))
  end
end
