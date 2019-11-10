class City < ApplicationRecord
  validates :name, uniqueness: true
end
