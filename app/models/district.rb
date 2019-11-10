class District < ApplicationRecord
  # Associations
  belongs_to :city

  # Validations
  validates :name, presence: true, uniqueness: { scope: :city_id }
  validates :city, presence: true
end
