require 'require_all'
require 'rspec'
require_all 'lib/world_cities_location'

describe WorldCitiesLocation::Country do
  let(:cities) { [1, 2, 3, 4, 5].collect{ |city_id| WorldCitiesLocation::City.new(id: city_id, name: Faker::Address.city)  } }
  let(:country_name) { Faker::Address.country }
  let(:country) { WorldCitiesLocation::Country.new(name: country_name, cities: cities) }

  describe '#new' do
    it 'should initialize' do
      expect(country).to be_a(WorldCitiesLocation::Country)
    end
  end

  describe '#highest_altitude_city' do
    it 'should return highest altitude city'
  end

  describe '#lowest_altitude_city' do
    it 'should return lowest altitude city'
  end

  describe '#sort_cities' do

  end

  describe '#total_cities' do
    it 'should return total number of cities' do
      expect(country.total_cities).to eq(cities.count)
    end
  end

  describe '#to_s' do
    it 'should return country name' do
      expect(country.to_s).to eq(country_name)
    end
  end
end
