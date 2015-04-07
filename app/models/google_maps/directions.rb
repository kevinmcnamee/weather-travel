module GoogleMaps
  class Directions
    include Virtus.model

    attribute :distance, Float
    attribute :duration, Integer
    attribute :start_location, Location
    attribute :end_location, Location
    attribute :polyline, String

    def initialize(args={})
      super mapped_args(args)
    end

    def duration_readable
      seconds = duration
      time_periods_shown = 2

      return "0 seconds" if seconds < 1
      [[60, :second], [60, :minute], [24, :hour], [7, :day], [52, :week], [1000, :year]].map{ |count, name|
        if seconds > 0
          seconds, n = seconds.divmod(count)
          "#{n.to_i} #{name}".pluralize(n.to_i) if n.to_i > 0
        end
      }.compact.last(time_periods_shown).reverse.join(' ')
    end
    private

    def mapped_args(args)
      r = DirectionsApi.directions_for(args[:from], args[:to]).with_indifferent_access

      route = r[:routes].first
      leg = route[:legs].first

      args = {}
      args[:polyline] = route[:overview_polyline][:points]
      args[:start_location] = {
        latitude: leg[:start_location][:lat],
        longitude: leg[:start_location][:lng],
        address: leg[:start_address]
      }
      args[:end_location] = {
        latitude: leg[:end_location][:lat],
        longitude: leg[:end_location][:lng],
        address: leg[:end_address]
      }
      args[:distance] = leg[:distance][:value] * 0.00062137
      args[:duration] = leg[:duration][:value]

      args
    end
  end
end
