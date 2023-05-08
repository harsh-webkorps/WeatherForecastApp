# frozen_string_literal: true

OpenWeatherAPI.configure do |config|
  config.api_key = ENV['OPEN_WEATHER_MAP_API_KEY']
end

Rails.configuration.open_weather_api
