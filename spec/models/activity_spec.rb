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
end
