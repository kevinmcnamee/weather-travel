require 'rails_helper'

describe 'Weather with lat lng' do
  let(:latitude) { 37.8267 }
  let(:longitude) { -122.423 }

  context 'with valid parameters' do
    before do
      get '/api/forecast', { latitude: latitude, longitude: longitude }
    end

    it 'has an OK response' do
      expect(response.status).to eq 200
    end

    it 'returns the latitude and longitude' do
      expect(json_response['latitude']).to eq latitude
      expect(json_response['longitude']).to eq longitude
    end

    it 'returns the current weather' do
      expect(json_response['currently']).to be_a(Hash)
    end

    it 'returns the daily weather' do
      expect(json_response['daily']).to be_a(Array)
    end

    it 'returns the hourly weather' do
      expect(json_response['hourly']).to be_a(Array)
    end
  end

  def json_response
    JSON.parse(response.body)
  end
end
