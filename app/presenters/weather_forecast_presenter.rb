class WeatherForecastPresenter
  def initialize(weather)
    @weather = weather
  end
  
  def weather
    @weather['weather'].first['main']
  end

  def description
    @weather['weather'].first['description']
  end

  def current_temp
    parse_temperature_in_celsius(@weather['main']['temp'])
  end

  def min_temp
    parse_temperature_in_celsius(@weather['main']['temp_min'])
  end

  def max_temp
    parse_temperature_in_celsius(@weather['main']['temp_max'])
  end

  def humidity
    @weather['main']['humidity']
  end

  private

  def parse_temperature_in_celsius(kelvin_temperature)
    "#{(kelvin_temperature - 273.15).round(2)} °C"
  end
end