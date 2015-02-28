# trulia_api
Gem for interacting with the Trulia API

Example:
trulia_api = TruliaAPI.new 'MY_API_KEY'

trulia_api.get_states returns a hash of state data.

trulia_api.get_cities('ca') returns a hash of city data.

trulia_api.get_zip_codes('ca') returns a hash of zip data.

trulia_api.get_counties_codes('ca') returns a hash of county data.

trulia_api.get_neighborhoods('san francisco', 'ca') returns a hash of neighborhood data.


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
