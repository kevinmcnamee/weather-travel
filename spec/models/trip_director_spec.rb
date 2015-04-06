require 'rails_helper'

describe TripDirector do
  let(:from) { 'from' }
  let(:to) { 'to' }
  let(:trip_director) { TripDirector.new(from, to) }

  describe '#new' do
    before do
      allow(TripDirector).to receive(:new).with(from, to)
      trip_director
    end

    it 'accepts sets a to and from location' do
      expect(TripDirector).to have_received(:new).with(from, to)
    end
  end

  describe '#directions' do
    let(:directions) { double(:directions) }

    before do
      allow(GoogleMaps::Directions).to receive(:new).with(from, to) { directions }
    end

    it 'instantiates a Google Maps directions' do
      expect(trip_director.directions).to eq directions
    end
  end
end
