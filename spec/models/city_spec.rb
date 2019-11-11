require 'rails_helper'

RSpec.describe City, type: :model do
  subject { build(:city) }

  describe '#name' do
    it { is_expected.to respond_to(:name) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end

  describe '#districts' do
    it { is_expected.to have_many(:districts).dependent(:destroy) }
  end

  describe '#activites' do
    it { is_expected.to have_many(:activities).through(:districts) }
  end
end
