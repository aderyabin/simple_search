class Post < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search,
                  against: [:title, :text]
end
