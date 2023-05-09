require 'rails_helper'

RSpec.describe WeatherForecastPresenter, type: :presenter do
  let(:location) {LocationFinderService.call('Indore')}
  let(:weather) {WeatherForecastService.call(location)[0]}
  let(:presenter) {WeatherForecastPresenter.new weather}
  
  describe '#call' do
    it 'returns weather' do
      expect(presenter.weather).to eq weather['weather'].first['main']
    end

    it 'returns description' do
      expect(presenter.description).to eq weather['weather'].first['description']
    end

    it 'returns current_temp' do
      expect(presenter.current_temp).to eq parse_temperature_in_celsius(weather['main']['temp'])
    end

    it 'returns min_temp' do
      expect(presenter.min_temp).to eq parse_temperature_in_celsius(weather['main']['temp_min'])
    end

    it 'returns max_temp' do
      expect(presenter.max_temp).to eq parse_temperature_in_celsius(weather['main']['temp_max'])
    end

    it 'returns humidity' do
      expect(presenter.humidity).to eq weather['main']['humidity']
    end
  end

  private

  def parse_temperature_in_celsius(kelvin_temperature)
    "#{(kelvin_temperature - 273.15).round(2)} °C"
  end
end