module GoogleMaps
  class Api
    def self.conn
      Faraday.new(url: root_url)
    end

    def self.api_key
      ENV['GOOGLE_MAPS_API_KEY']
    end
  end
end
