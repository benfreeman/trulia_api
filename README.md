# trulia_api
Gem for interacting with the Trulia API

Example:
trulia_api = TruliaAPI.new 'MY_API_KEY'

#http://developer.trulia.com/docs/read/LocationInfo/getCitiesInState ##
trulia_api.get_cities('ca') returns a hash of city data.

## http://developer.trulia.com/docs/read/LocationInfo/getCountiesInState ##
trulia_api.get_counties_codes('ca') returns a hash of county data.

## http://developer.trulia.com/docs/read/LocationInfo/getNeighborhoodsInCity ##
trulia_api.get_neighborhoods('san francisco', 'ca') returns a hash of neighborhood data.

## http://developer.trulia.com/docs/read/LocationInfo/getStates ##
trulia_api.get_states returns a hash of state data.

## http://developer.trulia.com/docs/read/LocationInfo/getZipCodesInState ##
trulia_api.get_zip_codes('ca') returns a hash of zip data.

## http://developer.trulia.com/docs/read/TruliaStats/getCityStats ##
trulia_api.get_city_stats("new orleans", "la", "2015-01-01", "2015-01-31") returns city data. (dates are startdate and enddate)

## http://developer.trulia.com/docs/read/TruliaStats/getCountyStats ##
trulia_api.get_county_stats("santa clara", "ca", "2015-01-01", "2015-01-31") returns state data. (dates are startdate and enddate)

## http://developer.trulia.com/docs/read/TruliaStats/getNeighborhoodStats ##
trulia_api.get_neighborhood_stats(neighborhood_id "2015-01-01", "2015-01-31") returns state data. (dates are startdate and enddate)

## http://developer.trulia.com/docs/read/TruliaStats/getStateStats ##
trulia_api.get_state_stats("new orleans", "la", "2015-01-01", "2015-01-31") returns state data. (dates are startdate and enddate)

## http://developer.trulia.com/docs/read/TruliaStats/getZipCodeStats ##
trulia_api.get_zip_stats(70119, "2015-01-01", "2015-01-31") returns state data. (dates are startdate and enddate)

Data looks something like this for each method:

"wisconsin" => {
  :abbreviation => "wi",
  :longitude => -90.010789,
  :latitude => 44.635609
}

"wyoming" => {
  :abbreviation => "wy",
  :longitude => -107.55144,
  :latitude => 42.999635
}
