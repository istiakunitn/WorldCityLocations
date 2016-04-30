require 'require_all'
require_all 'lib/world_cities_location'

CSV_FILE_PATH = File.join(File.dirname(__FILE__), 'World_Cities_Location_table.csv')
OUTPUT_FILE_PATH = File.join(File.dirname(__FILE__), 'oo_parsing.txt')

parser = WorldCitiesLocation::Parser.new(csv_file_path: CSV_FILE_PATH, csv_file_options: {:col_sep => ';'})

highest_cities_of_countries = parser.highest_cities_of_countries
output_file = File.open(OUTPUT_FILE_PATH, 'w')

highest_cities_of_countries.each do |city|
  line = "#{city.altitude}m - #{city.name}, #{city.country.name}"
  puts line
  output_file.puts(line)
end
