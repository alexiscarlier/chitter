require 'data_mapper'
require 'date'

class Peep

  include DataMapper::Resource

  property :id, Serial
  property :text, Text
  property :posted_on, DateTime

end
