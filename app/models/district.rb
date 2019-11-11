class District < ApplicationRecord
  # Associations
  belongs_to :city
  has_many :activities, dependent: :nullify

  # Validations
  validates :name, presence: true, uniqueness: { scope: :city_id }
  validates :city, presence: true
end
