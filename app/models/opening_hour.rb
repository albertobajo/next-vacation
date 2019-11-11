class OpeningHour < ApplicationRecord
  # Enum
  enum day_of_week: {
    monday: 0,
    tuesday: 1,
    wednesday: 2,
    thursday: 3,
    friday: 4,
    saturday: 5,
    sunday: 6
  }

  # Associations
  belongs_to :activity

  # Validations
  validates :day_of_week, presence: true
  validates :activity, presence: true
  validates :opens_at, presence: true, numericality: {
    greater_than_or_equal_to: 0,
    less_than: 86_400
  }
  validates :closes_at, presence: true, numericality: {
    greater_than: 0,
    less_than_or_equal_to: 86_400
  }
end
