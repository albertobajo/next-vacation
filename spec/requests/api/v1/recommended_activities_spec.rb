require 'rails_helper'

RSpec::Matchers.define_negated_matcher :not_include, :include

# This endpoint will receive a time range that the vacation-goer has available to perform an
# activity and the preferred category and should meet the specs.
RSpec.describe '/api/v1/recommended_activities.json', type: :request do
  context 'with invalid params' do
    it 'is expected to return 400 if any params lefts' do
      get '/api/v1/recommended_activity.json'
      expect(response.status).to eq(400)
    end
  end

  context 'with valid params' do
    before(:each) do
      @activity_one = create(:activity, minutes_spent: 60)
      @activity_two = create(:activity, minutes_spent: 120)

      create(
        :opening_hour, day_of_week: :th, opens_at: 36_000, closes_at: 72_000, activity: @activity_one
      )
      create(
        :opening_hour, day_of_week: :th, opens_at: 36_000, closes_at: 72_000, activity: @activity_two
      )
    end

    it 'is expected to return a single activity and all its details, in GeoJSON format' do
      get '/api/v1/recommended_activity.json?' \
          "category=#{@activity_one.category.name}&" \
          'from=201912120000&to=201912122300'

      expect(response).to match_response_schema('Feature')
    end

    describe 'returned activity' do
      it 'is expected to belong to the specified category' do
        create_list(:activity, 3)
        get '/api/v1/recommended_activity.json?' \
            "category=#{@activity_one.category.name}&" \
            'from=201912120000&to=201912122300'

        expect(response.body).to include(@activity_one.category.name)
      end

      it 'is expected to be open to the public' do
        get '/api/v1/recommended_activity.json?' \
            "category=#{@activity_one.category.name}&" \
            'from=201912110000&to=201912112300'

        expect(response.body).to_not include(@activity_one.category.name)
      end
    end

    context 'there are multiple options' do
      before do
        @activity_two.update(category: @activity_one.category)
      end

      it 'choose the one with the longest visit time that fits in the time range' do
        get '/api/v1/recommended_activity.json?' \
            "category=#{@activity_two.category.name}&" \
            'from=201912120000&to=201912122300'

        expect(response.body).to include(@activity_two.name)
      end

      it 'is expected to take visit duration into account' do
        get '/api/v1/recommended_activity.json?' \
            "category=#{@activity_two.category.name}&" \
            'from=201912121900&to=201912122100'

        expect(response.body).to include(@activity_one.category.name)
      end
    end
  end
end
