class Activity < ApplicationRecord
  # Associations
  belongs_to :category
  belongs_to :district
  belongs_to :location

  # Delegations
  delegate :city, to: :district

  # Validations
  validates :name, presence: true
  validates :district, presence: true
end
