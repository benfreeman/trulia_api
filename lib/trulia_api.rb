class TruliaAPI
  require 'open-uri'
  require 'nokogiri'

  def initialize(api_key)
    @api_key = api_key
  end

  def get_states
    states = {}
    states_xml = Nokogiri::HTML(open("http://api.trulia.com/webservices.php?library=LocationInfo&function=getStates&apikey=#{@api_key}"))
    states_xml.css("state").each do |state|
      states[state.css("name").text.downcase] = {
        abbreviation: state.css("statecode").text.downcase,
        longitude: state.css("longitude").text.to_d,
        latitude: state.css("latitude").text.to_d
      }
    end
    states
  end

  def get_cities(state)
    cities = {}
    cities_in_state_xml = Nokogiri::HTML(open("http://api.trulia.com/webservices.php?library=LocationInfo&function=getCitiesInState&state=#{state}&apikey=#{@api_key}"))
    cities_in_state_xml.css("city").each do |city|
      cities[city.css("name").text.downcase] = {
        zillow_id: city.css("cityid").text.to_i,
        longitude: city.css("longitude").text.to_d,
        latitude: city.css("latitude").text.to_d
      }
    end
    return cities
  end

  def get_zip_codes(state)
    zips = {}
    zip_codes_in_state_xml = Nokogiri::HTML(open("http://api.trulia.com/webservices.php?library=LocationInfo&function=getZipCodesInState&state=#{state}&apikey=#{@api_key}"))
    zip_codes_in_state_xml.css("zipcode").each do |zip|
      zips[zip.css("name").text.downcase] = {
        longitude: zip.css("longitude").text.to_d,
        latitude: zip.css("latitude").text.to_d
      }
    end
    return zips
  end

  def get_counties(state)
    counties = {}
    counties_in_state_xml = Nokogiri::HTML(open("http://api.trulia.com/webservices.php?library=LocationInfo&function=getCountiesInState&state=#{state}&apikey=#{@api_key}"))
    counties_in_state_xml.css("county").each do |county|
      counties[county.css("name").text.downcase] = {
        zillow_id: county.css("countyid").text.to_i,
        longitude: county.css("longitude").text.to_d,
        latitude: county.css("latitude").text.to_d
      }
    end
    return counties
  end

  def get_neighborhoods(city, state)
    neighborhoods = {}
    neighborhoods_in_city_xml = Nokogiri::HTML(open("http://api.trulia.com/webservices.php?library=LocationInfo&function=getNeighborhoodsInCity&city=#{CGI::escape(city)}&state=#{state}&apikey=#{@api_key}"))
    neighborhoods_in_city_xml.css("neighborhood").each do |neighborhood|
      neighborhoods[neighborhood.css("name").text.downcase] = {
        zillow_id: neighborhood.css("id").text.to_i,
      }
    end
    return neighborhoods
  end

  def get_city_stats(city, state, startdate, enddate)
    city_stats = {}
    bedrooms = {}
    city_stats_xml = Nokogiri::HTML(open("http://api.trulia.com/webservices.php?library=TruliaStats&function=getCityStats&city=#{CGI::escape(city)}&state=#{state}&startDate=#{startdate}&endDate=#{enddate}&apikey=#{@api_key}"))

    city_stats_xml.css("listingstat").each do |listingstat|
      weekend_date          = listingstat.css("weekendingdate").text.downcase
      listingstat.css("subcategory").each do |subcategory|
        type                  = subcategory.css("type").text.downcase

        bedrooms[type] = {
          properties:           subcategory.css("numberofproperties").text,
          medianlistingprice:   subcategory.css("medianlistingprice").text,
          averagelistingprice:  subcategory.css("averagelistingprice").text
        }
        city_stats[weekend_date] = bedrooms
      end
    end
    return city_stats
  end

  def get_state_stats(state, startdate, enddate)
    state_stats = {}
    bedrooms = {}
    state_stats_xml = Nokogiri::HTML(open("http://api.trulia.com/webservices.php?library=TruliaStats&function=getStateStats&state=#{state}&startDate=#{startdate}&endDate=#{enddate}&apikey=#{@api_key}"))

    state_stats_xml.css("listingstat").each do |listingstat|
      weekend_date          = listingstat.css("weekendingdate").text.downcase
      listingstat.css("subcategory").each do |subcategory|
        type                  = subcategory.css("type").text.downcase

        bedrooms[type] = {
          properties:           subcategory.css("numberofproperties").text,
          medianlistingprice:   subcategory.css("medianlistingprice").text,
          averagelistingprice:  subcategory.css("averagelistingprice").text
        }
        state_stats[weekend_date] = bedrooms
      end
    end
    return state_stats
  end

  def get_zip_stats(zip, startdate, enddate)
    zip_stats = {}
    bedrooms = {}
    zip_stats_xml = Nokogiri::HTML(open("http://api.trulia.com/webservices.php?library=TruliaStats&function=getZipCodeStats&zipCode=#{zip}&startDate=#{startdate}&endDate=#{enddate}&apikey=#{@api_key}"))

    zip_stats_xml.css("listingstat").each do |listingstat|
      weekend_date          = listingstat.css("weekendingdate").text.downcase
      listingstat.css("subcategory").each do |subcategory|
        type                  = subcategory.css("type").text.downcase

        bedrooms[type] = {
          properties:           subcategory.css("numberofproperties").text,
          medianlistingprice:   subcategory.css("medianlistingprice").text,
          averagelistingprice:  subcategory.css("averagelistingprice").text
        }
        zip_stats[weekend_date] = bedrooms
      end
    end
    return zip_stats
  end

  def get_neighborhood_stats(nid, startdate, enddate)
    neighborhood_stats = {}
    bedrooms = {}
    neighborhood_stats_xml = Nokogiri::HTML(open("http://api.trulia.com/webservices.php?library=TruliaStats&function=getNeighborhoodStats&neighborhoodId=#{nid}&startDate=#{startdate}&endDate=#{enddate}&apikey=#{@api_key}"))

    neighborhood_stats_xml.css("listingstat").each do |listingstat|
      weekend_date          = listingstat.css("weekendingdate").text.downcase
      listingstat.css("subcategory").each do |subcategory|
        type                  = subcategory.css("type").text.downcase

        bedrooms[type] = {
          properties:           subcategory.css("numberofproperties").text,
          medianlistingprice:   subcategory.css("medianlistingprice").text,
          averagelistingprice:  subcategory.css("averagelistingprice").text
        }
        neighborhood_stats[weekend_date] = bedrooms
      end
    end
    return neighborhood_stats
  end

  def get_county_stats(county, state, startdate, enddate)
    county_stats = {}
    bedrooms = {}
    county_stats_xml = Nokogiri::HTML(open("http://api.trulia.com/webservices.php?library=TruliaStats&function=getCountyStats&county=#{CGI::escape(county)}&state=#{state}&startDate=#{startdate}&endDate=#{enddate}&apikey=#{@api_key}"))

    county_stats_xml.css("listingstat").each do |listingstat|
      weekend_date          = listingstat.css("weekendingdate").text.downcase
      listingstat.css("subcategory").each do |subcategory|
        type                  = subcategory.css("type").text.downcase

        bedrooms[type] = {
          properties:           subcategory.css("numberofproperties").text,
          medianlistingprice:   subcategory.css("medianlistingprice").text,
          averagelistingprice:  subcategory.css("averagelistingprice").text
        }
        county_stats[weekend_date] = bedrooms
      end
    end
    return county_stats
  end

end
