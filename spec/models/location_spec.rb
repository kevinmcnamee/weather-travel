require 'rails_helper'

describe Location do
  let(:location) do
    Location.new(
      latitude: 40.12,
      longitude: 13.12,
      address: '123 main st'
    )
  end

  describe '#forecast' do
    let(:forecast) { double(:forecast, generate: {})}

    before do
      allow(Forecast).to receive(:new ) { forecast }
      location.forecast
    end

    it 'instantiates a forecast' do
      expect(Forecast).to have_received(:new).with(latitude: location.latitude, longitude: location.longitude)
    end

    it 'calls generate on forecast' do
      expect(forecast).to have_received(:generate)
    end
  end
end
