require 'rails_helper'

RSpec.describe Category, type: :model do
  subject { build(:category) }

  describe '#name' do
    it { is_expected.to respond_to(:name) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end

  describe '#activities' do
    it { is_expected.to have_many(:activities).dependent(:nullify) }
  end
end
