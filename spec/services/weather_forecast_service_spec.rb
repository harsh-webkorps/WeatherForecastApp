require 'rails_helper'

RSpec.describe WeatherForecastService, type: :service do
  describe '#call' do
    it 'returns weather information' do
      location = LocationFinderService.call('Indore')
      weather, cached = WeatherForecastService.call(location)
      expect(weather['cod']).to eq 200
      expect(weather).to have_key('wind')
      expect(weather).to have_key('clouds')
      expect(weather['main']).to have_key('humidity')
      expect(weather['main']).to have_key('temp')
    end

    it 'raises and returns nil as weather information' do
      location = LocationFinderService.call('jodhpur')
      weather, cached = WeatherForecastService.call(location)
      expect(weather).to be_nil
    end
  end
end