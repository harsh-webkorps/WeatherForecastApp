# frozen_string_literal: true

# This controller class provides info related to weather forecast
class WeatherForecastsController < ApplicationController
  def index; end

  def current_weather
    @weather = WeatherForecastService.call(params[:address])
    if @weather[:code] == 200
      render 'current_weather'
    else
      render 'error_page'
    end
  end
end
