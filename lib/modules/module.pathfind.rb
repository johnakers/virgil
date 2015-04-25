module Pathfind

  # input is an array of words... need address 1 & 2
  def self.determine_input(array)
    array = array.split(' ')
    split_point = array.index('from')
    [ array[1..split_point-1].join(' '), array[split_point+1..-1].join(' ') ]
  end

  # input is an Array of size 2, each a String (e.g. '760 Market Street, San Francisco, CA')
  def self.get_locations(locations)
    first, second = locations[0], locations[1]
    coords_one = Geocoder.coordinates(first)
    coords_two = Geocoder.coordinates(second)
    coords_mid = Geocoder::Calculations.geographic_center([coords_one, coords_two])
    [coords_one, coords_two, coords_mid]
  end

  # input are 3 sets of coordinates in an Array
  def self.direction_path(array)
    array.map! { |coords| coords.join(',') }
    "https://www.google.com/maps/dir/#{array[0]}/#{array[1]}"
  end

end