require 'rails_helper'

# It should return all information about the available activities, in GeoJSON format
# It should be able to filter by category, location or district. If no filter is provided, it should list all activities


RSpec.describe Api::V1::ActivitiesController, type: :controller do
  describe 'GET #index' do
    # it 'does something' do
    #   # expect(response.content_type).to eq('application/geo+json')
    #   get :index
    #   expect(response.content_type).to eq('application/json')
    # end

    it 'should return all information about the available activities'
    it 'should return data in GeoJSON format'

    context 'with filters' do
      it 'should be able to filter by category'
      it 'should be able to filter by location'
      it 'should be able to filter by district'
    end

    context 'without filters' do
      it 'should list all activities'
    end
  end
end
