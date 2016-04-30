require 'require_all'
require 'rspec'
require_all 'lib/world_cities_location'

describe WorldCitiesLocation::Country do
  describe '#new' do
    it 'should initialize' do
      country = WorldCitiesLocation::Country.new
      expect(country).to be_a(WorldCitiesLocation::Country)
    end
  end
end
