class TripDirector
  attr_reader :from, :to

  def initialize(from, to)
    @from = from
    @to = to
  end

  def directions
    @directions ||= GoogleMaps::Directions.new(from: from, to: to)
  end
end
