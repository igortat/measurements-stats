require 'rack/test'
require 'rspec'

ENV['RACK_ENV'] = 'test'
ENV['MONGO_HOSTADDR'] = '127.0.0.1:27017'  
ENV['MONGO_DATABASE'] = 'dbtest'

module RSpecMixin
  include Rack::Test::Methods

  def app
      RestApi
  end
end

RSpec.configure do |c| 
  c.include RSpecMixin 
end