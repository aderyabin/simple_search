# frozen_string_literal: true

class Post < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search,
                  against: %i[title text]
end
