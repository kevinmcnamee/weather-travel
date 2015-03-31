require 'rails_helper'

describe Forecast do
  let(:latitude) { 41.44 }
  let(:longitude) { -90.44 }
  let(:duststorm) { double(:duststorm, forecast: {}) }

  let(:forecast) { Forecast.new(latitude: latitude, longitude: longitude) }

  before do
    allow(Duststorm).to receive(:new) { duststorm }
  end

  describe '#generate' do
    it 'instantiates a new duststorm object' do
      expect(Duststorm).to receive(:new).with(latitude, longitude)
      forecast.generate
    end

    it 'calls forecast on the duststorm instance' do
      expect(duststorm).to receive(:forecast)
      forecast.generate
    end
  end
end
