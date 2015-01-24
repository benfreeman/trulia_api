class TruliaAPI
  require 'open-uri'
  require 'nokogiri'

  def self.get_states
    states = {}
    states_xml = Nokogiri::HTML(open("http://api.trulia.com/webservices.php?library=LocationInfo&function=getStates&apikey=w39ngptt27hu9gfhqsgnwsxv"))
      states_xml.css("state").each do |state|
        states[state.css("name").text.downcase] = {
          abbreviation: state.css("statecode").text.downcase,
          longitude: state.css("longitude").text.to_d,
          latitude: state.css("latitude").text.to_d
        }
      end
  end

  def self.get_cities(state)
    cities = {}
    cities_in_state_xml = Nokogiri::HTML(open("http://api.trulia.com/webservices.php?library=LocationInfo&function=getCitiesInState&state=#{state}&apikey=w39ngptt27hu9gfhqsgnwsxv"))
      cities_in_state_xml.css("city").each do |city|
        cities[city.css("name").text.downcase] = {
          longitude: city.css("longitude").text.to_d,
          latitude: city.css("latitude").text.to_d
        }
      end
  end

  def self.get_zip_codes(state)
    zips = {}
    zip_codes_in_state_xml = Nokogiri::HTML(open("http://api.trulia.com/webservices.php?library=LocationInfo&function=getZipCodesInState&state=#{state}&apikey=w39ngptt27hu9gfhqsgnwsxv"))
      zip_codes_in_state_xml.css("zipcode").each do |zip|
        zips[zip.css("name").text.downcase] = {
          zillow_id: zip.css("zipid").text,
          longitude: zip.css("longitude").text.to_d,
          latitude: zip.css("latitude").text.to_d
        }
      end
  end

  def self.get_counties(state)
    counties = {}
    counties_in_state_xml = Nokogiri::HTML(open("http://api.trulia.com/webservices.php?library=LocationInfo&function=getCountiesInState&state=#{state}&apikey=w39ngptt27hu9gfhqsgnwsxv"))
      counties_in_state_xml.css("county").each do |county|
        counties[county.css("name").text.downcase] = {
          zillow_id: county.css("countyid").text,
          longitude: county.css("longitude").text.to_d,
          latitude: county.css("latitude").text.to_d
        }
      end
  end

  def self.get_neighborhoods(city, state)
    neighborhoods = {}
    neighborhoods_in_city_xml = Nokogiri::HTML(open("http://api.trulia.com/webservices.php?library=LocationInfo&function=getNeighborhoodsInCity&city=#{city}&state=#{state}&apikey=w39ngptt27hu9gfhqsgnwsxv"))
      neighborhoods_in_city_xml.css("neighborhood").each do |neighborhood|
        neighborhoods[neighborhood.css("name").text.downcase] = {
          zillow_id: neighborhood.css("id").text,
        }
      end
  end
end
