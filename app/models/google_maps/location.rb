module GoogleMaps
  class Location
    include Virtus.model

    attribute :latitude, Float
    attribute :longitude, Float
    attribute :address, String
  end
end
