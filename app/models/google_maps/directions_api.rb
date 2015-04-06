module GoogleMaps
  class DirectionsApi < Api
    def self.directions_for(from, to)
      response = conn.get(
        root_url + "?origin=#{from}&destination=#{to}&key=#{api_key}"
      )

      if response.success?
        JSON.parse(response.body)
      end
    end

    def self.root_url
      'https://maps.googleapis.com/maps/api/directions/json'
    end
  end
end
