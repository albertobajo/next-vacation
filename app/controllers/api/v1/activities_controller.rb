class Api::V1::ActivitiesController < Api::V1::GeojsonApiController
  def index
    @activities = Activity.eager_load(:category, :location, :district, :opening_hours)
    @activities = @activities.with_category(params['category']) if params['category']
    @activities = @activities.with_district(params['district']) if params['district']
    @activities = @activities.with_location(params['location']) if params['location']
  end
end
