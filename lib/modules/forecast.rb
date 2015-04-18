require 'dotenv'
Dotenv.load

class Forecast
  class << self

    # alias for ForecastIO key
    def key
      ENV['FORECAST_TOKEN']
    end

    # 'location' is a string (e.g. "San Francisco")
    def state_weather(location)
      coordinates = Geocoder.coordinates(location)
      lat, long, unknown  = coordinates[0], coordinates[1], "... I'm afraid I don't know"
      response = HTTParty.get("https://api.forecast.io/forecast/#{Forecast.key}/#{lat},#{long}")
      response.parsed_response['currently']['summary'].downcase
      currently = response.parsed_response['currently']['summary'].downcase || "#{uknown}"
      hourly = response.parsed_response['hourly']['summary'].gsub!(/[^0-9A-Za-z]/,' ') || "#{uknown}"
      daily = response.parsed_response['daily']['summary'].gsub!(/[^0-9A-Za-z]/,' ') || "#{uknown}"
      "currently the weather is #{currently}. It will be #{hourly} and #{daily}"
    end

  end # self
end