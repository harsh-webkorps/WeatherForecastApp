require 'rails_helper'

RSpec.describe LocationFinderService, type: :service do
  describe '#call' do
    it 'returns location fetched by geocode API' do
      location = LocationFinderService.call('Indore')
      expect(location).to be_an_instance_of(Geocoder::Result::Nominatim)
      expect(location.data["address"]["city"]).to eq('Indore')
      expect(location.data["address"]["state"]).to eq('Madhya Pradesh')
      expect(location.data["address"]["country"]).to eq('India')
    end

    it 'returns nil' do
      location = LocationFinderService.new('this is invalid location').call
      expect(location).to be_nil
    end
  end
end