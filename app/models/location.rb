class Location < ApplicationRecord
  # Associations
  has_many :activities, dependent: :nullify

  # Validations
  validates :name, presence: true, uniqueness: true
end
