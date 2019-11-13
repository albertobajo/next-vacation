require 'rails_helper'

# This endpoint will receive a time range that the vacation-goer has available to perform an
# activity and the preferred category and should meet the specs.
RSpec.describe '/api/v1/recommended_activities.json', type: :request do
  context 'with valid params' do
    let!(:activity) { create(:activity) }

    it 'is expected to return a single activity and all its details, in GeoJSON format' do
      get "/api/v1/recommended_activity.json?category=#{activity.category.name}"

      expect(response).to match_response_schema('Feature')
    end

    describe 'returned activity' do
      it 'is expected to belong to the specified category' do
        create_list(:activity, 3)
        get "/api/v1/recommended_activity.json?category=#{activity.category.name}"

        expect(response.body).to include(activity.category.name)
      end

      it 'is expected to be open to the public' do
        closed_activity = create(:activity, opening_hours: [])
        get "/api/v1/recommended_activity.json?category=#{closed_activity.category.name}"

        expect(response.body).to_not include(closed_activity.category.name)
      end

      it 'is expected to be visited taking'
    end

    context 'there are multiple options' do
      it 'choose the one with the longest visit time that fits in the time range'
    end
  end
end
