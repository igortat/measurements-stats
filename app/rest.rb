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
#    content_type :json
#    range = JSON.parse(request.body.read)['range']
    range = JSON.parse(params[:json])['range']
    documents = db['measures'].find({
      'datapoint' => Integer(params[:datapoint]), 
      'timestamp' => {"$gte" => range[0], "$lt" => range[1]}
    })
    "#{JSON.pretty_generate(documents.to_a)}"
#    "hello #{range[0]} to #{range[1]}"     
  end
end