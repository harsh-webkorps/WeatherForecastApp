# frozen_string_literal: true

# Service to retrieve the current weather forecast
class LocationFinderService < ApplicationService
  def initialize(address)
    @address = address
  end
  
  def call
    Geocoder.search(@address).last
  end
end
  