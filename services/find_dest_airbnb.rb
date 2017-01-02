require 'sinatra'
require 'mongo'
require 'geocoder'

class FindDestAirbnb < Sinatra::Base
  def self.call(from:)
    if Geocoder.search(from).any?
      address = Geocoder.search(from)[0].data["formatted_address"].split(', ')[1]
      address_no_space = address.gsub(/[^a-zA-Z]/, " ").rstrip.lstrip
      final_address = address_no_space.sub('Street', "St").rstrip.lstrip
      Mongo::Logger.logger.level = ::Logger::FATAL
      db = Mongo::Client.new( ENV['MONGODB_HOSTNAME'], :database => ENV['MONGODB_DATABASE'])
      data = db[ENV['MONGODB_COLLECTION_NAME_Airbnb']]
             .find({'From' => final_address}).to_a
      result = Hash.new
      data.map do |info|
        result[info["Count"]] = info["To"]
      end
      result
    else
      result = 'empty'
      result
    end
  end
end
