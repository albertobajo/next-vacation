require 'rails_helper'

RSpec.describe Activity, type: :model do
  subject { create(:activity) }

  describe '#name' do
    it { is_expected.to respond_to(:name) }
    it { is_expected.to validate_presence_of(:name) }
    it 'is expected to validate uniqueness scoped to district/city'
  end

  describe '#minutes_spent' do
    it { is_expected.to respond_to(:minutes_spent) }
  end

  describe '#hours_spent' do
    it { is_expected.to respond_to(:hours_spent) }
    it 'is expected to return hours rounded upward with 2 decimals' do
      subject.minutes_spent = 61
      expect(subject.hours_spent).to eq(1.02)
    end
  end

  describe '#lonlat' do
    it { is_expected.to respond_to(:lonlat) }
  end

  describe '#category' do
    it { is_expected.to belong_to(:category) }
  end

  describe '#district' do
    it { is_expected.to belong_to(:district) }
    it { is_expected.to validate_presence_of(:district) }
  end

  describe '#location' do
    it { is_expected.to belong_to(:location) }
  end

  describe '#city' do
    it { is_expected.to respond_to(:city) }
  end

  describe '#opening_hours' do
    it { is_expected.to have_many(:opening_hours).dependent(:destroy) }
  end

  describe '.with_city' do
    it 'is expected to return activities from the given city (name)' do
      district = create(:district)
      activities = create_list(:activity, 2, district: district)
      create_list(:activity, 2)

      expect(Activity.with_city(district.city.name)).to match_array(activities)
    end
  end

  describe '.from_to_same_day' do
    before(:each) do
      # 08:00-10:00
      @activity_one = create(:activity, minutes_spent: 60)
      @oh_one = create(
        :opening_hour, activity: @activity_one, day_of_week: :mo, opens_at: 28_800, closes_at: 36_000
      )

      # 12:00-14:00
      @activity_two = create(:activity, minutes_spent: 60)
      @oh_two = create(
        :opening_hour, activity: @activity_two, day_of_week: :mo, opens_at: 43_200, closes_at: 50_400
      )
    end

    it 'is expected to return activities that open and closes inside the time range' do
      expect(
        Activity.from_to_same_day(DateTime.parse('201912231200'), DateTime.parse('201912231400'))
      ).to match_array([@activity_two])
    end

    context 'with time to visit' do
      it 'is expected to return activities that opens out of the time range' do
        expect(
          Activity.from_to_same_day(DateTime.parse('201912230900'), DateTime.parse('201912231100'))
        ).to match_array([@activity_one])
      end

      it 'is expected to return activities that closes out of the time range' do
        expect(
          Activity.from_to_same_day(DateTime.parse('201912231300'), DateTime.parse('201912231400'))
        ).to match_array([@activity_two])
      end
    end

    context 'with no time to visit' do
      it 'is expected to discard activities that opens or closes in the time range' do
        expect(
          Activity.from_to_same_day(DateTime.parse('201912231330'), DateTime.parse('201912231430'))
        ).to match_array([])
      end
    end
  end

  describe '.from_to' do
    before(:each) do
      # 08:00-10:00
      @activity_one = create(:activity, minutes_spent: 60)
      @oh_one = create(
        :opening_hour, activity: @activity_one, day_of_week: :tu, opens_at: 28_800, closes_at: 36_000
      )

      # 12:00-14:00
      @activity_two = create(:activity, minutes_spent: 60)
      @oh_two = create(
        :opening_hour, activity: @activity_two, day_of_week: :tu, opens_at: 43_200, closes_at: 50_400
      )
    end

    it 'is expected to return activities that open and closes inside the time range' do
      expect(
        Activity.from_to(DateTime.parse('201912231200'), DateTime.parse('201912251400'))
      ).to match_array([@activity_one, @activity_two])
    end

    context 'with time to visit' do
      it 'is expected to return activities that opens out of the time range' do
        expect(
          Activity.from_to(DateTime.parse('201912241300'), DateTime.parse('201912251100'))
        ).to match_array([@activity_two])
      end

      it 'is expected to return activities that closes out of the time range' do
        expect(
          Activity.from_to(DateTime.parse('201912231300'), DateTime.parse('201912240900'))
        ).to match_array([@activity_one])
      end
    end

    context 'with no time to visit' do
      it 'is expected to discard activities that opens or closes in the time range' do
        expect(
          Activity.from_to(DateTime.parse('201912231300'), DateTime.parse('201912240830'))
        ).to match_array([])
      end
    end
  end
end
