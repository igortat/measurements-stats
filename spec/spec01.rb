#spec01.rb
ENV['RACK_ENV'] = 'test'
#ENV['MONGO_DATABASE'] = 'dbtest'  

require 'rspec'
require 'rack/test'
require File.expand_path('../../app/rest.rb', __FILE__)

class RestApiTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    RestApi
  end

  def test_post_service
    payload = {"1460205648" => 10}
    post '/7', payload.to_json, {'Content-Type' => 'application/json'} 
    assert last_response.created?
  end

end