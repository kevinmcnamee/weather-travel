require 'rails_helper'

describe Api::ForecastController do
  let(:forecast) { double(:forecast, generate: {} ) }

  describe '#index' do
    before do
      allow(Forecast).to receive(:new) { forecast }
      get :index, forecast_params
    end

    context 'with valid params' do
      let(:forecast_params) do
        { latitude: 'lat', longitude: 'lng' }
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

    context 'with invalid params' do
      let(:forecast_params) { {} }

      it 'returns an error' do
        expect(response.body).to eq 'longitude and latitude are required'
      end

      it 'does not call generate on forecast' do
        expect(forecast).not_to have_received(:generate)
      end
    end
  end
end
