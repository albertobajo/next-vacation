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
  
  def self.from_to(from_time, to_time)
    table = Arel::Table.new(:opening_hours)
    from_time_sec = from_time.seconds_since_midnight
    to_time_sec = to_time.seconds_since_midnight

    # get first day
    from_day = table[:day_of_week].in(from_time.wday)
    from_last_entry = table[:last_entry_at].gteq(from_time_sec)
    from_inside = (table[:opens_at].gteq(from_time_sec).and table[:closes_at].lteq(from_time_sec))
    from_first_exit = table[:first_exit_at].lteq(from_time_sec)
    first_day = from_day.and(from_last_entry.or(from_inside.or(from_first_exit)))

    # get in between
    in_between_days = (from_time...to_time).map(&:wday).uniq.drop(1)
    in_between = table[:day_of_week].in(in_between_days)

    # get last day
    to_day = table[:day_of_week].in(to_time.wday)
    to_last_entry = table[:last_entry_at].gteq(to_time_sec)
    to_inside = (table[:opens_at].gteq(to_time_sec).and table[:closes_at].lteq(to_time_sec))
    to_first_exit = table[:first_exit_at].lteq(to_time_sec)
    last_day = to_day.and(to_last_entry.or(to_inside.or(to_first_exit)))

    left_outer_join = Activity.arel_table
                              .join(table, Arel::Nodes::OuterJoin)
                              .on(Activity.arel_table[:id].eq(table[:activity_id]))
                              .join_sources

    joins(left_outer_join)
      .where(first_day.or(in_between.or(last_day)))
  end
end
