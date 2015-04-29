module Pathfind

  def self.direction_path(input)
    return invalid_input if self.incorrect?(input)
    parsed_input = self.parsed_input(input)
    coords = self.get_coords(parsed_input)
    return invalid_input if parsed_input.nil? || coords.nil?
    coords.map! { |coord| coord.join(',') }
    "here is a map to your path: `https://www.google.com/maps/dir/#{coords[0]}/#{coords[1]}`"
  end

  # use geocoder to grab and return lat / longs
  def self.get_coords(locations)
    first, second = locations[0], locations[1]
    coords_one = Geocoder.coordinates(first)
    coords_two = Geocoder.coordinates(second)
    coords_one.nil? || coords_two.nil? ? nil : [coords_one, coords_two]
  end

  # input is an array of words... need address 1 & 2
  # based on the syntax of input... we can split accordingly
  def self.parsed_input(array)
    array = array.split(' ')
    split_point = array.index('from')
    [ array[1..split_point-1].join(' '), array[split_point+1..-1].join(' ') ]
  end

  #
  def self.incorrect?(input)
    input.nil? || !input.include?('to') || !input.include?('from')
  end

  #
  def self.invalid_input
    "I believe that input is incorrect. It should be `virgil pathfind to [address] from [address]`"
  end

end