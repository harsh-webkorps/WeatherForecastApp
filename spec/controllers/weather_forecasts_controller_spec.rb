require 'rails_helper'

RSpec.describe WeatherForecastsController, type: :controller do
  describe "GET index" do 
    it "renders the current_weather template" do
      get :current_weather, params: {address: 'Indore'}
      expect(response).to render_template("current_weather")
    end
  end
end