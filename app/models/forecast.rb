class Forecast
  attr_reader :latitude, :longitude

  def initialize(args)
    @latitude = args[:latitude]
    @longitude = args[:longitude]
  end

  def generate
    duststorm.forecast
  end

  private

  def duststorm
    @duststorm ||= Duststorm.new(latitude, longitude)
  end
end
