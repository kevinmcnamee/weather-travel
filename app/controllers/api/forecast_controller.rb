class Api::ForecastController < ApplicationController
  def index
    @forecast = Forecast.new(forecast_params)

    render json: @forecast.generate
  end

  def forecast_params
    params.permit(:latitude, :longitude)
  end
end
