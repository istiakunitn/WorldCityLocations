require 'csv'
CSV_FILE_PATH = File.join(File.dirname(__FILE__), 'World_Cities_Location_table.csv')
OUTPUT_FILE_PATH = File.join(File.dirname(__FILE__), 'simple_parsing.txt')

highest_cities_of_countries = {}

City = Struct.new('City', :id, :name, :latitude, :longitude, :altitude, :country)

CSV.foreach(CSV_FILE_PATH, {:col_sep => ';'}) do |line|
  city_id = line[0]
  city_country = line[1]
  city_name = line[2]
  city_latitude = line[3].to_f
  city_longitude = line[4].to_f
  city_altitude = line[5].to_f

  city = City.new(city_id, city_name, city_latitude, city_longitude, city_altitude, city_country)

  if highest_cities_of_countries[city_country].nil?
    highest_cities_of_countries[city_country] = city
  else
    if city.altitude > highest_cities_of_countries[city_country].altitude
      highest_cities_of_countries[city_country] = city
    end
  end
end

output_file = File.open(OUTPUT_FILE_PATH, 'w')

highest_cities_of_countries.values.sort {|left, right|
  right.altitude <=> left.altitude
}.each do |city|
  line = "#{city.altitude}m - #{city.name}, #{city.country}"
  puts line
  output_file.puts(line)
end
