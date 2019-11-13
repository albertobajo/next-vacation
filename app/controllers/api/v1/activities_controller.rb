class Api::V1::ActivitiesController < ApplicationController
  before_action :set_headers
  before_action :set_filters

  def index
    @activities = Activity.eager_load(:category, :location, :district, :opening_hours)
    @activities = @activities.with_category(@category_name) if @category_name
    @activities = @activities.with_district(@district_name) if @district_name
    @activities = @activities.with_location(@location_name) if @location_name
  end

  private

  def set_headers
    response.headers['Content-Type'] = 'application/geo+json'
  end

  def set_filters
    @category_name = params['category']
    @district_name = params['district']
    @location_name = params['location']
  end
end
