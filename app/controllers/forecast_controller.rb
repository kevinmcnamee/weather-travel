class ForecastController < ApplicationController
  def index
  end

  def search
    @trip = TripDirector.new(trip_params[:from], trip_params[:to])
  end

  private

  def trip_params
    params.require(:forecast).permit(:to, :from)
  end
end
