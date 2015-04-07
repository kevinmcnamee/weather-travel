class Location
  include Virtus.model

  attribute :latitude, Float
  attribute :longitude, Float
  attribute :address, String

  def forecast
    @forecast ||= Forecast.new(
      latitude: latitude,
      longitude: longitude
    ).generate
  end
end
