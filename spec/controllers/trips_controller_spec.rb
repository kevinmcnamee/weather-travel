require 'rails_helper'

describe TripsController do
  describe '#index' do
    it 'returns a successful response' do
      get :index
      expect(response.status).to eq 200
    end
  end

  describe '#search' do
    let(:from) { '45440' }
    let(:to) { '07506' }
    let(:params) do
      { trip: {to: to, from: from} }
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
