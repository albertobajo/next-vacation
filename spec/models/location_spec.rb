require 'rails_helper'

RSpec.describe Location, type: :model do
  subject { build(:location) }

  describe '.name' do
    it { is_expected.to respond_to(:name) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end
end
