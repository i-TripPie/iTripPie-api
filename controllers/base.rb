require 'sinatra'
require 'json'

# Configuration Sharing Web Service
class TriphoboAPI < Sinatra::Base
  enable :logging

  get '/?' do
    'TriphoboAPI web service is up and running at /api/v1'
  end
end
