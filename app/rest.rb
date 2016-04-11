# rest.rb
require 'json/ext'
require 'mongo'
require 'sinatra'

class RestApi < Sinatra::Base
  db = Mongo::Client.new('mongodb://127.0.0.1:27017/measures')

  post '/:datapoint' do
    payload = JSON.parse(request.body.read)
    payload.each do |k, v| 
      db['measures'].insert_one({
        datapoint: Integer(params[:datapoint]), 
        timestamp: Integer(k), 
        measure: v
      })
    end
    
    halt
  end
  
  get '/:datapoint' do
    content_type :json
#    range = JSON.parse(request.body.read)['range']
    range = JSON.parse(params[:json])['range']
    documents = db['measures'].aggregate([
      {"$match" => { 'datapoint' => 2, 'timestamp' => {"$gte" => range[0], "$lt" => range[1]}}},      
      {"$group" => { 
        _id: "$datapoint", 
        min: {"$min" => "$measure"},
        max: {"$max" => "$measure"}, 
        avg: {"$avg" => "$measure"} 
      }}
    ])
    h = documents.to_a.first
    h.delete('_id')
    JSON.pretty_generate(h)
  end
end