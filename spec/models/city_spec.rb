require 'rails_helper'

RSpec.describe City, type: :model do
  it { should have_many(:districts) }

  describe '.name' do
    it { is_expected.to respond_to(:name) }
    it { should validate_uniqueness_of(:name) }
  end
end
