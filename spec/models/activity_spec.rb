require 'rails_helper'

RSpec.describe Activity, type: :model do
  subject { build(:activity) }

  describe '.name' do
    it { is_expected.to respond_to(:name) }
    it { is_expected.to validate_presence_of(:name) }
    # it { is_expected.to validate_uniqueness_of(:name).scoped_to(:city_id) }
  end

  describe '.minutes_spent' do
    it { is_expected.to respond_to(:minutes_spent) }
  end

  describe '.lonlat' do
    it { is_expected.to respond_to(:lonlat) }
  end

  describe '.category' do
    it { is_expected.to belong_to(:category) }
  end

  describe '.district' do
    it { is_expected.to belong_to(:district) }
    it { is_expected.to validate_presence_of(:district) }
  end

  describe '.location' do
    it { is_expected.to belong_to(:location) }
  end

  describe '.city' do
    it { is_expected.to respond_to(:city) }
  end
end
