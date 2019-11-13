require 'rails_helper'

RSpec::Matchers.define_negated_matcher :not_include, :include

RSpec.describe Api::V1::ActivitiesController, type: :controller do
  render_views

  describe 'GET index' do
    it 'is expected to return a application/geo+json content-type' do
      get :index, params: { format: 'application/geo+json' }

      expect(response.content_type).to eq('application/geo+json')
    end

    it 'is expected to return all information about the activities in GeoJSON format' do
      activity = create(:activity)
      get :index, params: { format: 'application/geo+json' }

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

        get :index, params: { category: category.name, format: 'application/geo+json' }

        expect(response.body)
          .to include(*expected_activities.pluck(:name))
          .and not_include(*activities.pluck(:name))
      end

      it 'is expected to filter by location' do
        location = create(:location)
        expected_activities = create_list(:activity, 2, location: location)

        get :index, params: { location: location.name, format: 'application/geo+json' }

        expect(response.body)
          .to include(*expected_activities.pluck(:name))
          .and not_include(*activities.pluck(:name))
      end

      it 'is expected to filter by district' do
        district = create(:district)
        expected_activities = create_list(:activity, 2, district: district)

        get :index, params: { district: district.name, format: 'application/geo+json' }

        expect(response.body)
          .to include(*expected_activities.pluck(:name))
          .and not_include(*activities.pluck(:name))
      end
    end

    context 'without filters' do
      let!(:activities) { create_list(:activity, 10) }

      it 'is expected list all activities' do
        get :index, params: { format: 'application/geo+json' }

        json_response = JSON.parse(response.body)
        expect(json_response['features'].length).to eq(10)
      end
    end
  end
end
