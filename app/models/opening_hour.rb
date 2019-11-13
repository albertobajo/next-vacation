class OpeningHour < ApplicationRecord
  # Enum
  enum day_of_week: {
    su: 0,
    mo: 1,
    tu: 2,
    we: 3,
    th: 4,
    fr: 5,
    sa: 6
  }

  # Hooks
  before_save :set_entry_exit_fields

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

  # Instance Methods
  def time_to_s
    "#{Time.at(opens_at).utc.strftime('%H:%M')}-#{Time.at(closes_at).utc.strftime('%H:%M')}"
  end

  private

  def set_entry_exit_fields
    self.first_exit_at = opens_at + activity.minutes_spent * 60
    self.last_entry_at = closes_at - activity.minutes_spent * 60
  end
end
