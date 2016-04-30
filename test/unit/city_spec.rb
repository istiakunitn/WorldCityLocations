require 'require_all'
require 'rspec'
require 'faker'

require_all 'lib/world_cities_location'

describe WorldCitiesLocation::City do
  let(:city_id) { Faker::Number.digit }
  let(:city_name) { Faker::Address.city }
  let(:city) { WorldCitiesLocation::City.new(id: city_id, name: city_name) }

  describe '#new' do
    it 'should initialize' do
      expect(city).to be_a(WorldCitiesLocation::City)
    end
  end

  describe '#to_s' do
    it 'should return country name' do
      expect(city.to_s).to eq(city_name)
    end
  end
end
