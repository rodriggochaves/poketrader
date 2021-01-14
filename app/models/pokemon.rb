class Pokemon < ApplicationRecord
  validates :name, presence: true
  validates :poke_index, presence: true

  scope :search, ->(query) { where("name LIKE ?", "#{sanitize_sql_like(query)}%") }
end
