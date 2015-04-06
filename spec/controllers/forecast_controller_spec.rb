require 'rails_helper'

describe ForecastController do
  describe '#search' do
    let(:from) { '45440' }
    let(:to) { '07506' }
    let(:params) do
      { forecast: {to: to, from: from} }
    end

    let(:trip_director) { double(:trip_director) }

    before do
      allow(TripDirector).to receive(:new).with(from, to) { trip_director }
    end

    it 'calls the Trip Director' do
      expect(TripDirector).to receive(:new).with(from, to)
      post :search, params.merge(format: :js)
    end

    it 'assigns the trip' do
      post :search, params.merge(format: :js)
      expect(assigns(:trip)).to eq trip_director
    end
  end
end
