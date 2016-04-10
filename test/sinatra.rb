# sinatra.rb
require 'sinatra'

class HelloWorldApp < Sinatra::Base
  get '/' do
    "Hello, world!"
  end
  
  get '/:name' do
     "Hello, #{params[:name]}!"
   end
end