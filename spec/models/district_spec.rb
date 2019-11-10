require 'rails_helper'

RSpec.describe District, type: :model do
  subject { create(:district) }

  describe '.name' do
    it { is_expected.to respond_to(:name) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name).scoped_to(:city_id) }
  end

  describe '.city' do
    it { is_expected.to belong_to(:city) }
    it { is_expected.to validate_presence_of(:city) }
  end
end
