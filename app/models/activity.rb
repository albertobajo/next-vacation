class Activity < ApplicationRecord
  # Associations
  belongs_to :category
  belongs_to :district
  belongs_to :location
  has_many :opening_hours, dependent: :destroy

  # Scopes
  # scope :with_category, lambda { |name|
  #   joins(:category).merge(Category.where(name: name))
  # }
  # scope :with_location, lambda { |name|
  #   joins(:location).merge(Location.where(name: name))
  # }
  # scope :with_district, lambda { |name|
  #   joins(:district).merge(District.where(name: name))
  # }
  scope :with_city, lambda { |name|
    joins(district: :city).where(districts: { cities: { name: name } })
  }

  # Delegations
  delegate :city, to: :district

  # Validations
  validates :name, presence: true
  validates :district, presence: true
end
