# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'weather_forecasts#index'
  get '/current_weather', to: 'weather_forecasts#current_weather', as: 'current_weather'
end
