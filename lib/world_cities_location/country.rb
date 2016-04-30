module WorldCitiesLocation
  class Country
    attr_accessor :name, :cities

    def initialize(attrs = {})
      @name = attrs.fetch(:name, nil)
      @cities = attrs.fetch(:cities, [])
    end

    #
    # This method will return a +WorldCitiesLocation::City+ from +cities+, which has highest altitude
    #
    # @return WorldCitiesLocation::City
    def highest_altitude_city
      @lowest_altitude_city ||= sort_cities(:altitude, :desc).first
    end

    #
    # This method will return a +WorldCitiesLocation::City+ from +cities+, which has lowest altitude
    #
    # @return WorldCitiesLocation::City
    def lowest_altitude_city
      @lowest_altitude_city ||= sort_cities(:altitude, :asc).first
    end

    #
    # This method will sort the +cities+ by +attribute+ of +WorldCitiesLocation::City+
    #
    # @return [WorldCitiesLocation::City]
    def sort_cities(attribute, dir = :desc)
      cities.sort do |left, right|
        dir == :desc ? right.send(attribute) <=> left.send(attribute) : left.send(attribute) <=> right.send(attribute)
      end
    end

    def total_cities
      cities.length
    end

    def to_s
      name
    end
  end
end
