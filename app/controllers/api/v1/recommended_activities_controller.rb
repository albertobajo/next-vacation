class Api::V1::RecommendedActivitiesController < Api::V1::GeojsonApiController
  def show
    from_time = DateTime.parse(params['from'])
    to_time = DateTime.parse(params['to'])

    @activity = Activity.includes(:category, :location, :district)
                        .with_category(params['category'])
                        .from_to(from_time, to_time)
                        .order(minutes_spent: :desc)
                        .first
  end
end
