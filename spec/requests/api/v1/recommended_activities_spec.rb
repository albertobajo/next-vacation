require 'rails_helper'

# This endpoint will receive a time range that the vacation-goer has available to perform an
# activity and the preferred category and should meet the specs.
RSpec.describe '/api/v1/recommended_activities.json', type: :request do
  it 'should return a single activity and all its details, in GeoJSON format'
  describe 'returned activity' do
    it 'should belong to the specified category and be open to the public at the time of visit'
  end
  context 'there are multiple options' do
    it 'choose the one with the longest visit time that fits in the time range'
  end
end
