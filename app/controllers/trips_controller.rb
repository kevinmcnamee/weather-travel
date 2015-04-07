class TripsController < ApplicationController
  def index
  end

  def search
    @trip = TripDirector.new(trip_params[:from], trip_params[:to])
  end

  private

  def trip_params
    params.require(:trip).permit(:to, :from)
  end
end
