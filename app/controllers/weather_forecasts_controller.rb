# frozen_string_literal: true

# This controller class provides info related to weather forecast
class WeatherForecastsController < ApplicationController
  def index; end

  def current_weather
    location = LocationFinderService.call(params[:address])
    if location.nil?
      @error = {message: 'Location not found', code: 422} 
    else
      @weather, @cached = WeatherForecastService.call(location)
      @error = {
                  message: 'Unable to fetch weather forcast for this address',
                  code: 422
               } if @weather.nil?
    end
  end
end
