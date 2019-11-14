require 'rails_helper'

RSpec::Matchers.define_negated_matcher :not_include, :include

# This endpoint will return all information about the available activities and should be able to
# filter by category, location or district. If no filter is provided, it should list all activities.
RSpec.describe '/api/v1/activities.json', type: :request do

  it 'is expected to return a application/geo+json content-type' do
    get '/api/v1/activities.json'
    expect(response.content_type).to eq('application/geo+json')
  end

  it 'is expected to return all information about the activities in GeoJSON format' do
    activity = create(:activity)
    get '/api/v1/activities.json'

    expect(response).to match_response_schema('FeatureCollection')
    expect(response.body).to include(
      activity.name,
      activity.hours_spent.to_s,
      activity.category.name,
      activity.location.name,
      activity.district.name
    )
  end

  context 'with filters' do
    let(:activities) { create_list(:activity, 10) }

    it 'is expected to filter by category' do
      category = create(:category)
      expected_activities = create_list(:activity, 2, category: category)

      get "/api/v1/activities.json?category=#{category.name}"

      expect(response.body)
        .to include(*expected_activities.pluck(:name))
        .and not_include(*activities.pluck(:name))
    end

    it 'is expected to filter by location' do
      location = create(:location)
      expected_activities = create_list(:activity, 2, location: location)

      get "/api/v1/activities.json?location=#{location.name}"

      expect(response.body)
        .to include(*expected_activities.pluck(:name))
        .and not_include(*activities.pluck(:name))
    end

    it 'is expected to filter by district' do
      district = create(:district)
      expected_activities = create_list(:activity, 2, district: district)

      get "/api/v1/activities.json?district=#{district.name}"

      expect(response.body)
        .to include(*expected_activities.pluck(:name))
        .and not_include(*activities.pluck(:name))
    end
  end

  context 'without filters' do
    let!(:activities) { create_list(:activity, 10) }

    it 'is expected list all activities' do
      get '/api/v1/activities.json'

      json_response = JSON.parse(response.body)
      expect(json_response['features'].length).to eq(10)
    end
  end
end