# filldata.rb
require 'mongo'

db = Mongo::Client.new('mongodb://127.0.0.1:27017/measures')
db[:measures].insert_one({datapoint: 1.0, timestamp: 1460205629, measure: 15.0})
  