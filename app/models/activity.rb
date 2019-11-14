class Activity < ApplicationRecord
  # Associations

  belongs_to :category
  belongs_to :district
  belongs_to :location
  has_many :opening_hours, dependent: :destroy

  # Scopes

  scope :with_category, lambda { |name|
    joins(:category).merge(Category.where(name: name))
  }
  scope :with_location, lambda { |name|
    joins(:location).merge(Location.where(name: name))
  }
  scope :with_district, lambda { |name|
    joins(:district).merge(District.where(name: name))
  }
  scope :with_city, lambda { |name|
    joins(district: :city).where(districts: { cities: { name: name } })
  }

  # Delegations

  delegate :city, to: :district

  # Validations

  validates :name, presence: true
  validates :district, presence: true

  # Instance Methods

  def hours_spent
    (minutes_spent / 60.0).ceil(2)
  end

  # Class Methods

  def self.from_to_same_day(time_a, time_b)
    table = Arel::Table.new(:opening_hours)

    minutes_available = (time_b.to_time - time_a.to_time) / 60

    day = table[:day_of_week].in(time_a.wday)
    duration = Activity.arel_table[:minutes_spent].lteq(minutes_available)
    last_entry = table[:last_entry_at].gteq(time_a.seconds_since_midnight)
    first_exit = table[:first_exit_at].lteq(time_b.seconds_since_midnight)
    query = day.and(duration.and(last_entry.and(first_exit)))

    left_outer_join = Activity.arel_table
                              .join(table, Arel::Nodes::OuterJoin)
                              .on(Activity.arel_table[:id].eq(table[:activity_id]))
                              .join_sources

    joins(left_outer_join).where(query)
  end

  def self.from_to(time_a, time_b)
    return Activity.from_to_same_day(time_a, time_b) if time_a.to_date == time_b.to_date

    table = Arel::Table.new(:opening_hours)

    # first day activities
    from_day = table[:day_of_week].in(time_a.wday)
    last_entry = table[:last_entry_at].gteq(time_a.seconds_since_midnight)
    first_day = from_day.and(last_entry)

    # in between days activities
    in_between_days = (time_a...time_b).map(&:wday).uniq.drop(1)
    in_between = table[:day_of_week].in(in_between_days)

    # last day activities
    to_day = table[:day_of_week].in(time_b.wday)
    first_exit = table[:first_exit_at].lteq(time_b.seconds_since_midnight)
    last_day = to_day.and(first_exit)

    left_outer_join = Activity.arel_table
                              .join(table, Arel::Nodes::OuterJoin)
                              .on(Activity.arel_table[:id].eq(table[:activity_id]))
                              .join_sources

    joins(left_outer_join).where(first_day.or(in_between.or(last_day)))
  end
end
