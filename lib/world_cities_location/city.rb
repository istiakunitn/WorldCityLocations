module WorldCitiesLocation
  class City
    attr_accessor :id, :name, :latitude, :longitude, :altitude, :country

    def initialize(attrs = {})
      @id = attrs[:id]
      @name = attrs[:name]
      @latitude = attrs[:latitude].to_f
      @longitude = attrs[:longitude].to_f
      @altitude = attrs[:altitude].to_f
      @country = attrs[:country]
    end

    def to_s
      name
    end
  end
end