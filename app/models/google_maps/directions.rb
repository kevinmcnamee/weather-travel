module GoogleMaps
  class Directions
    include Virtus.model

    attribute :distance, Float
    attribute :duration, String
    attribute :start_location, Location
    attribute :end_location, Location
    attribute :polyline, String

    def initialize(args)
      super mapped_args(args)
    end

    private

    def mapped_args(args)
      r = DirectionsApi.directions_for(args[:from], args[:to]).with_indifferent_access

      route = r[:routes].first
      leg = route[:legs].first

      args = {}
      args[:polyline] = route[:overview_polyline]
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
      args[:duration] = human_readable_time(leg[:duration][:value])

      args
    end

    def human_readable_time(seconds)
      time_periods_shown = 2
      use_short_names = false

      return "0 seconds" if seconds < 1
      short_name = {:second => :sec, :minute => :min, :hour => :hr, :day => :day, :week => :wk, :year => :yr}
      [[60, :second], [60, :minute], [24, :hour], [7, :day], [52, :week], [1000, :year]].map{ |count, name|
        if seconds > 0
          seconds, n = seconds.divmod(count)
          name = short_name[name] if use_short_names
          "#{n.to_i} #{name}".pluralize(n.to_i) if n.to_i > 0
        end
      }.compact.last(time_periods_shown).reverse.join(' ')
    end
  end
end
