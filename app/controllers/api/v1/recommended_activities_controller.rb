class Api::V1::RecommendedActivitiesController < Api::V1::GeojsonApiController
  def show
    are_params_valid = params['from'].present? && params['to'].present? && params['category'].present?

    if are_params_valid
      @activity = Activity.includes(:category, :location, :district)
                          .with_category(params['category'])
                          .from_to(DateTime.parse(params['from']), DateTime.parse(params['to']))
                          .order(minutes_spent: :desc)
                          .first

      render json: {} if @activity.blank?
    else
      render json: {}, status: :bad_request
    end
  end
end
