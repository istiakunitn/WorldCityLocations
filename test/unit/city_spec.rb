require 'require_all'
require 'rspec'
require_all 'lib/world_cities_location'

describe WorldCitiesLocation::City do
  describe '#new' do
    it 'should initialize' do
      city = WorldCitiesLocation::City.new
      expect(city).to be_a(WorldCitiesLocation::City)
    end
  end
end
