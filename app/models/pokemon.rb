class Pokemon < ApplicationRecord
  validates :name, presence: true
  validates :poke_index, presence: true
end
