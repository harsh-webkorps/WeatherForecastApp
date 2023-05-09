# frozen_string_literal: true

# Service to retrieve the current weather forecast
class WeatherForecastService < ApplicationService
  def initialize(location)
    @location = location
  end

  def call
    zipcode = @location.postal_code
    country_code = @location.country_code
    cache_key = "weather_forecast/#{zipcode}/#{country_code}"
    cached = true
    response = Rails.cache.fetch(cache_key, expires_in: 30.minutes) do
      cached = false
      Rails.configuration.open_weather_api.current(zipcode: zipcode, country_code: country_code).to_json
    end
    [JSON(response), cached]

  rescue
    [nil, false]
  end
end
