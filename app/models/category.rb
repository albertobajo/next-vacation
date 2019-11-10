class Category < ApplicationRecord
  # Validations
  validates :name, presence: true, uniqueness: true
end
