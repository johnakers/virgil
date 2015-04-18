require 'dotenv'
Dotenv.load

class Forecast
  class << self

    # alias for ForecastIO key
    def key
      ENV['FORECAST_TOKEN']
    end

    # 'location' is a string (e.g. "San Francisco")
    def get_weather(location)
      coordinates = Geocoder.coordinates(location)
      return nil if Forecast.location_invalid?(coordinates)
      lat, long, unknown  = coordinates[0], coordinates[1], "... I'm afraid I don't know"
      HTTParty.get("https://api.forecast.io/forecast/#{Forecast.key}/#{lat},#{long}")
    end

    def parse_weather(response)
      currently = response.parsed_response['currently']['summary'].downcase || "#{uknown}"
      hourly = response.parsed_response['hourly']['summary'].gsub!(/[^0-9A-Za-z]/,' ') || "#{uknown}"
      daily = response.parsed_response['daily']['summary'].gsub!(/[^0-9A-Za-z]/,' ') || "#{uknown}"
      { :currently => currently, :hourly => hourly, :daily => daily }
    end

    def get(location)
      response = Forecast.get_weather(location)
      return "I do not know that location" if response.nil?        
      results  = Forecast.parse_weather(response)
      "currently the weather is #{results[:currently]}. It will be #{results[:hourly]} and #{results[:daily]}"
    end

    def location_invalid?(geocoder_response)
      true if geocoder_response.nil?
    end

  end # self
end