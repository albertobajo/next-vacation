require 'rails_helper'

RSpec.describe OpeningHour, type: :model do
  subject { create(:opening_hour) }

  describe '#day_of_week' do
    it { is_expected.to respond_to(:day_of_week) }
    it { is_expected.to validate_presence_of(:day_of_week) }
    it do
      dotw = {
        mo: 0,
        tu: 1,
        we: 2,
        th: 3,
        fr: 4,
        sa: 5,
        su: 6
      }

      is_expected.to define_enum_for(:day_of_week).with_values(dotw)
    end
  end

  describe '#opens_at' do
    it { is_expected.to respond_to(:opens_at) }
    it { is_expected.to validate_presence_of(:opens_at) }
    it do
      is_expected.to validate_numericality_of(:opens_at)
        .is_greater_than_or_equal_to(0)
        .is_less_than(86_400)
    end
  end

  describe '#closes_at' do
    it { is_expected.to respond_to(:closes_at) }
    it { is_expected.to validate_presence_of(:closes_at) }
    it do
      is_expected.to validate_numericality_of(:closes_at)
        .is_greater_than(0)
        .is_less_than_or_equal_to(86_400)
    end

    it 'is expected to be greater than #opens_at'
  end

  describe '#activity' do
    it { is_expected.to belong_to(:activity) }
    it { is_expected.to validate_presence_of(:activity) }
  end

  context 'overlaps with another OpeningHour' do
    it 'is expected to be invalid'
  end
end
