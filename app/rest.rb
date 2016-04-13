# rest.rb
require 'json/ext'
require 'mongo'
require 'sinatra'

class RestApi < Sinatra::Base
  db_url  = ENV['MONGO_HOSTADDR'] || '127.0.0.1:27017'
  db_name = ENV['MONGO_DATABASE'] || 'measurementstat'  
  db      = Mongo::Client.new([db_url], :database => db_name)

  post '/:datapoint' do
    payload = JSON.parse(request.body.read)
    payload.each do |k, v| 
      db['measures'].insert_one({
        datapoint: params[:datapoint].to_i, 
        timestamp: k.to_i, 
        measure: v
      })
    end
    
    halt 201
  end
  
  get '/:datapoint' do
    content_type :json
    range = JSON.parse(params[:json])['range']
    documents = db['measures'].aggregate([
      {"$match" => { 'datapoint' => params[:datapoint].to_i, 'timestamp' => {"$gte" => range[0], "$lt" => range[1]}}},      
      {"$group" => { 
        _id: "$datapoint", 
        min: {"$min" => "$measure"},
        max: {"$max" => "$measure"}, 
        avg: {"$avg" => "$measure"} 
      }},
      {"$project" => {_id: 0, min: 1, max: 1, avg: 1}}
    ])
    documents.to_a.first.to_json
  end
  
end