class City < ApplicationRecord
  # Associations
  has_many :districts, dependent: :destroy
  has_many :activities, through: :districts

  # Validations
  validates :name, presence: true, uniqueness: true
end
