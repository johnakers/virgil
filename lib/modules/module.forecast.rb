require 'dotenv'
Dotenv.load

module Forecast

  # alias for ForecastIO key
  def self.key
    ENV['FORECAST_TOKEN']
  end

  # 'location' is a string (e.g. "San Francisco")
  def self.get_weather(location)
    coordinates = Geocoder.coordinates(location)
    return nil if self.location_invalid?(coordinates)
    lat, long = coordinates[0], coordinates[1]
    HTTParty.get("https://api.forecast.io/forecast/#{self.key}/#{lat},#{long}")
  end

  def self.parse_weather(response)
    currently = response.parsed_response['currently']['summary'].downcase || "#{uknown}"
    hourly = response.parsed_response['hourly']['summary'].gsub!(/[^0-9A-Za-z]/,' ') || "#{uknown}"
    daily = response.parsed_response['daily']['summary'].gsub!(/[^0-9A-Za-z]/,' ') || "#{uknown}"
    { :currently => currently, :hourly => hourly, :daily => daily }
  end

  def self.get(location)
    response = self.get_weather(location)
    return "I do not know that location" if response.nil?        
    results  = self.parse_weather(response)
    "currently the weather is #{results[:currently]}. It will be #{results[:hourly]} and #{results[:daily]}"
  end

  def self.location_invalid?(geocoder_response)
    true if geocoder_response.nil?
  end

end