require 'sinatra'
require 'mongo'

class FindDestTriphobo < Sinatra::Base
  def self.call(from:)
    Mongo::Logger.logger.level = ::Logger::FATAL
    db = Mongo::Client.new( ENV['MONGODB_HOSTNAME'], :database => ENV['MONGODB_DATABASE'])
    data = db[ENV['MONGODB_COLLECTION_NAME_Trip']]
           .find({'From' => from}).to_a
    result = Hash.new
    data.map do |info|
      result[info["Count"]] = info["To"]
    end
    result
  end
end
