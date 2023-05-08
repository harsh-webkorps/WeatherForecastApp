# frozen_string_literal: true

# Service to retrieve the current weather forecast
class WeatherForecastService
  def initialize(address)
    @address = address
  end

  def self.call(address)
    WeatherForecastService.new(address).retrieve_forecast
  end

  def retrieve_forecast
    location = Geocoder.search(@address).last
    return { code: 404, message: 'Location not found' } if location.nil?

    zipcode = location.postal_code
    country_code = location.country_code
    cache_key = "weather_forecast/#{zipcode}/#{country_code}"
    cached_response = Rails.cache.read(cache_key)
    if cached_response.present?
      handle_weather_api_response(cached_response, true)
    else
      response = Rails.configuration.open_weather_api.current zipcode: zipcode, country_code: country_code
      Rails.cache.write(cache_key, response.to_json, expires_in: 30.minutes)
      handle_weather_api_response(response.to_json, false)
    end
  end

  def handle_weather_api_response(response, from_cache)
    response = JSON response
    if response['cod'] == 200
      parse_weather_api_response(response, from_cache)
    else
      { code: response['cod'], message: response['message'] }
    end
  end

  def parse_weather_api_response(response, from_cache)
    {
      weather: response['weather'].first['main'],
      weather_description: response['weather'].first['description'],
      current_temp: parse_temperature_in_celsius(response['main']['temp']),
      min_temp: parse_temperature_in_celsius(response['main']['temp_min']),
      max_temp: parse_temperature_in_celsius(response['main']['temp_max']),
      humidity: response['main']['humidity'],
      from_cache: from_cache,
      code: response['cod']
    }
  end

  private

  def parse_temperature_in_celsius(kelvin_temperature)
    "#{(kelvin_temperature - 273.15).round(2)} °C"
  end
end
