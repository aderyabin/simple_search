# frozen_string_literal: true

require 'dry-initializer'

class Repo
  extend Dry::Initializer

  option :id
  option :name
  option :description
  option :url
  option :avatar_url
  option :username
  option :owner_type
  option :topics

  def ==(other)
    to_json == other.to_json
  end
end
