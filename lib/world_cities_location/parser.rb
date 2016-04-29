require 'csv'

module WorldCitiesLocation
  class Parser
    attr_accessor :csv_file_path, :csv_file_options, :cities
    protected :cities

    #
    # Construct a new +WorldCitiesLocation::Parser+ using the +options+ Hash.
    # Available options are:
    #
    # <b><tt>:csv_file_path</tt></b>::      CSV file path for parsing cities
    # <b><tt>:csv_file_options</tt></b>::   The +csv_file_options+ parameter can be anything CSV::new() understands
    #
    # The +csv_file_path+ is required and if it is not provided an +Exception+ will be thrown
    #
    # ==== Usage example:
    #   parser = WorldCitiesLocation::Parser.new(csv_file_path: '....', csv_file_options: {:col_sep => ';'})
    #
    #   parser.parse do |city|
    #     p city.inspect
    #   end
    #
    #   highest_cities = parser.highest_cities_of_countries
    #

    def initialize(options = {})
      raise Exception, 'csv_file_path is missing' unless options[:csv_file_path]

      @csv_file_path = options[:csv_file_path]
      @csv_file_options = options.fetch(:csv_file_options, {})
      @cities = nil
    end

    #
    # This method is intended as the primary interface for reading the CSV file. Each row of
    # file will be passed as +WorldCitiesLocation::City+ to the provided +block+ in turn
    #
    # ==== Usage example:
    #   parser.parse do |city|
    #     p city
    #   end
    #
    # Check also +highest_cities_of_countries()+ as an example
    #
    # This method will return an array of +WorldCitiesLocation::Country+
    #
    # @return [WorldCitiesLocation::Country]
    def parse
      if @cities.nil?
        @cities = []
        CSV.foreach(csv_file_path, csv_file_options) do |line|

          # line[0] is id
          # line[1] is country name
          # line[2] is city name
          # line[3] is latitude
          # line[4] is longitude
          # line[5] is altitude

          city = find_or_create_city({
                                         id: line[0],
                                         name: line[2],
                                         latitude: line[3].to_f,
                                         longitude: line[4].to_f,
                                         altitude: line[5].to_f,
                                         country: line[1]
                                     })
          if block_given?
            yield city
          end
        end
      else
        @cities.each do |city|
          yield city
        end if block_given?
      end

      @cities
    end

    #
    # This method will pick the +WorldCitiesLocation::City+ with highest altitude
    # for each +WorldCitiesLocation::Country+ while looping through each line of CSV
    #
    # This method will return an array of +WorldCitiesLocation::City+
    #
    # @return [WorldCitiesLocation::City]
    def highest_cities_of_countries
      highest_cities_of_countries = {}
      parse do |city|
        if highest_cities_of_countries[city.country].nil?
          highest_cities_of_countries[city.country] = city
        else
          if city.altitude > highest_cities_of_countries[city.country].altitude
            highest_cities_of_countries[city.country] = city
          end
        end
      end
      highest_cities_of_countries.values.sort { |left, right|
        right.altitude <=> left.altitude
      }
    end

    private
    def find_or_create_city(attributes = {})
      city = cities.detect { |city| city.id == attributes[:id] }
      if city.nil?
        city = City.new(attributes)
        @cities << city
      end
      city
    end
  end
end

