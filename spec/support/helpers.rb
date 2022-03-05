# frozen_string_literal: true

module Helpers
  def json_fixture(filename)
    JSON.parse(
      File.read(Rails.root.join("spec/fixtures/json/#{filename}")),
      symbolize_names: true
    )
  end
end
