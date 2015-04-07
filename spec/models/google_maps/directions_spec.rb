require 'rails_helper'

module GoogleMaps
  describe Directions do
    let(:from) { 'from' }
    let(:to) { 'to' }
    let(:api_response) do
      {
        routes: [
          {
            legs: [
              {
                distance: { value: 12312 },
                duration: { value: 2323 },
                end_address: "Dayton, OH 45440, USA",
                end_location: {
                  lat: 39.6729776,
                  lng: -84.09628909999999
                },
                start_address: "Hawthorne, NJ 07506, USA",
                start_location: {
                  lat: 40.96166909999999,
                  lng: -74.1538076
                },
              }
            ],
            overview_polyline: {
              points: 'asdfasdfasdfasdf'
            },
            steps: []
          }
        ]
      }
    end

    let(:directions) { GoogleMaps::Directions.new(from: from, to: to) }

    before do
      allow(DirectionsApi).to receive(:directions_for).with(from, to) { api_response }
    end

    describe '#new' do
      it 'calls the DirectionsApi' do
        expect(DirectionsApi).to receive(:directions_for).with(from, to) { api_response }
        directions
      end
    end

    describe 'attributes' do
      it 'sets proper attributes' do
        expect(directions.start_location).to be_a(Location)
        expect(directions.end_location).to be_a(Location)
        expect(directions.polyline).to eq api_response[:routes].first[:overview_polyline][:points]
      end
    end

    describe '#duration_readable' do
      let(:duration) { 3610 } # 1 hour 10 seconds

      it 'returns a human readable version of the time' do
        directions.duration = duration

        expect(directions.duration_readable).to eq '1 hour 10 seconds'
      end
    end
  end
end
