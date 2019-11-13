class Api::V1::GeojsonApiController < ApplicationController
  before_action :set_content_type

  private

  def set_content_type
    response.headers['Content-Type'] = 'application/geo+json'
  end
end