#spec00.rb
ENV['RACK_ENV'] = 'test'
ENV['MONGO_HOSTADDR'] = '127.0.0.1:27017'  
ENV['MONGO_DATABASE'] = 'dbtest'

require 'rspec'
require 'rack/test'
require File.expand_path('../../app/rest.rb', __FILE__)

class RestApiTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    RestApi
  end

  def test_integration
    Mongo::Client.new([ENV['MONGO_HOSTADDR']], :database => ENV['MONGO_DATABASE']).database.drop
    
    payload = {
      "1460205601" => 2,
      "1460205648" => 4,
      "1460205701" => 6
    }
    post '/42', payload.to_json, {'Content-Type' => 'application/json'} 
    assert last_response.created?
 
    params1 = {'range' => [1460205600,1460205700]}
    get '/42', :json => params1.to_json
    assert_equal JSON.parse(last_response.body)['avg'].to_i, 3
    assert_equal JSON.parse(last_response.body)['max'].to_i, 4  
        
    params2 = {'range' => [1460205600,1460205800]}
    get '/42', :json => params2.to_json
    assert_equal JSON.parse(last_response.body)['min'].to_i, 2
    assert_equal JSON.parse(last_response.body)['avg'].to_i, 4
    assert_equal JSON.parse(last_response.body)['max'].to_i, 6  

  end

end