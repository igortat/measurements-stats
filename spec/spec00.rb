#spec00.rb
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

  def test_get_service
    params = {'range' => [1460205628,1460205706]}
    get '/2', :json => params.to_json
#      print last_request.url
#      print last_response.body    
    assert last_response.body.include?("avg")
  end

end