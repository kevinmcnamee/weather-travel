class ForecastController < ApplicationController
  def index
    render json: Duststorm.new('37.8267', '-122.423').forecast
  end
end
