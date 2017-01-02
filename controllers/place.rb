require 'sinatra'

class TriphoboAPI < Sinatra::Base
  post '/api/v1/locations' do
    content_type 'application/json'

    mongo = JSON.parse(request.body.read)
    location_arr_trip = FindDestTriphobo.call(from: mongo['location'])
    location_arr_airbnb = FindDestAirbnb.call(from: mongo['location'])
    if location_arr_trip or location_arr_airbnb
      {location_arr_trip: location_arr_trip,
       location_arr_airbnb: location_arr_airbnb}.to_json
    else
      halt 401, 'FAILED to connect mongodb'
    end
  end
end
