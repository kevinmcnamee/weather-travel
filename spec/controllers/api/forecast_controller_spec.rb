require 'rails_helper'

describe Api::ForecastController do
  let(:forecast) { double(:forecast, generate: {} ) }
  let(:forecast_params) do
    { latitude: 'lat', longitude: 'lng' }
  end

  describe '#index' do
    before do
      allow(Forecast).to receive(:new) { forecast }
      get :index, forecast_params
    end

    it 'instantiates a Forecast' do
      expect(Forecast).to have_received(:new).with(forecast_params)
    end

    it 'assigns forecast' do
      expect(assigns(:forecast)).to eq forecast
    end

    it 'calls generate on forecast' do
      expect(forecast).to have_received(:generate)
    end
  end
end
