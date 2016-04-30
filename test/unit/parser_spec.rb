require 'require_all'
require 'rspec'
require_all 'lib/world_cities_location'

CSV_FILE_PATH = File.join(File.dirname(__FILE__), '../fixtures/World_Cities_Location_table.csv')

describe WorldCitiesLocation::Parser do
  # TODO use Faker to generate dynamic csv data
  let(:countries_cities){
    {
        'Afghanistan' => ['Kabul', 'Kandahar', 'Mazar-e Sharif', 'Herat'],
        'Albania' => %w(Tirana Durres Elbasan Vlore Shkoder Fier-Cifci),
        'Algeria' => %w(Algiers Oran Constantine),
        'United States' => ['New York City', 'Los Angeles', 'Chicago', 'Houston'],
        'Andorra' => ['Andorra la Vella', 'les Escaldes']
    }
  }
  let(:countries_highest_city){
    {
        'Afghanistan' => 'Kabul',
        'Albania' => 'Elbasan',
        'Algeria' => 'Constantine',
        'United States' => 'Chicago',
        'Andorra' => 'les Escaldes'
    }
  }
  let(:total_cities) {
    countries_cities.collect{|country, cities| cities.count }.inject(:+)
  }
  let(:total_countries) {
    countries_cities.keys.count
  }
  let(:country_names){
    countries_cities.keys
  }
  let(:parser) { WorldCitiesLocation::Parser.new(csv_file_path: CSV_FILE_PATH, csv_file_options: {:col_sep => ';'}) }


  describe '#new' do
    context 'without csv_file_path option' do
      it 'should throws exception' do
        expect { WorldCitiesLocation::Parser.new }.to raise_error(Exception, 'csv_file_path is missing')
      end
    end

    context 'with csv_file_path option' do
      it 'should initialize' do
        parser = WorldCitiesLocation::Parser.new(csv_file_path: CSV_FILE_PATH, csv_file_options: {:col_sep => ';'})
        expect(parser).to be_a(WorldCitiesLocation::Parser)
      end
    end
  end

  describe '#parse' do
    it 'should return array of countries' do
      countries = parser.parse
      expect(countries).to be_an(Array)
      expect(countries.count).to eq(total_countries)
      countries.each do |country|
        expect(country_names).to include(country.name)
        expect(country).to be_a(WorldCitiesLocation::Country)
      end
    end

    it 'should assigns cities under countries' do
      countries = parser.parse
      countries.each do |country|
        expect(country.cities.count).to eq(countries_cities[country.name].count)
        country.cities.each do |city|
          expect(countries_cities[country.name]).to include(city.name)
          expect(city).to be_a(WorldCitiesLocation::City)
        end
      end
    end
  end

  describe '#highest_cities_of_countries' do
    it 'should return array of highest cities of each country' do
      cities = parser.highest_cities_of_countries
      expect(cities).to be_an(Array)
      expect(cities.count).to eq(countries_highest_city.keys.count)
      cities.each do |city|
        expect(countries_highest_city[city.country.name]).to eq(city.name)
        expect(city).to be_a(WorldCitiesLocation::City)
      end
    end
  end

  describe '#lowest_cities_of_countries' do
    it 'should return array of lowest cities of each country'
  end

  describe  '#find_or_create_city' do
    it 'should find a city when it is existed' do
      parser.parse
      country = parser.countries.sample
      city_id = country.cities.first.id
      total_cities_parsed = parser.countries.map(&:total_cities).inject(:+)
      expect(total_cities_parsed).to eq(total_cities)
      parser.send(:find_or_create_city, country, {id: city_id})
      total_cities_parsed = parser.countries.map(&:total_cities).inject(:+)
      expect(total_cities_parsed).to eq(total_cities)
    end

    it 'should create a city when it is not existed' do
      parser.parse
      country = parser.countries.sample
      city_id = '0'
      total_cities_parsed = parser.countries.map(&:total_cities).inject(:+)
      expect(total_cities_parsed).to eq(total_cities)
      parser.send(:find_or_create_city, country, {id: city_id})
      total_cities_parsed = parser.countries.map(&:total_cities).inject(:+)
      expect(total_cities_parsed).to eq(total_cities + 1)
    end

    it 'should return a city with given attribute' do
      parser.parse
      country = parser.countries.sample
      city = parser.send(:find_or_create_city, country, {id: '0'})
      expect(city).to be_a(WorldCitiesLocation::City)
      expect(city.id).to eq('0')
      expect(city.country).to eq(country)
    end
  end

  describe  '#find_or_create_country' do
    it 'should find a country when it is existed' do
      parser.parse
      country = parser.countries.sample
      country_name = country.name
      total_countries_parsed = parser.countries.length
      expect(total_countries_parsed).to eq(total_countries)
      parser.send(:find_or_create_country, country_name)
      total_countries_parsed = parser.countries.length
      expect(total_countries_parsed).to eq(total_countries)
    end

    it 'should create a country when it is not existed' do
      parser.parse
      country_name = 'Italy'
      total_countries_parsed = parser.countries.length
      expect(total_countries_parsed).to eq(total_countries)
      parser.send(:find_or_create_country, country_name)
      total_countries_parsed = parser.countries.length
      expect(total_countries_parsed).to eq(total_countries + 1)
    end

    it 'should return a country with given attribute' do
      parser.parse
      country_name = 'Italy'
      country = parser.send(:find_or_create_country, country_name)
      expect(country).to be_a(WorldCitiesLocation::Country)
      expect(country.name).to eq(country_name)
    end
  end
end