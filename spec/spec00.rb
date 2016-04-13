#spec00.rb
require_relative 'spec_helper.rb'
require File.expand_path('../../app/rest.rb', __FILE__)

RSpec.describe "Specing REST" do
  
  before(:all) do
    Mongo::Client.new([ENV['MONGO_HOSTADDR']], :database => ENV['MONGO_DATABASE']).database.drop
        
    @payload = {
      "1460205601" => 2,
      "1460205648" => 4,
      "1460205701" => 6
    } 
  end
  
  it "POST spec" do   
    post '/42', @payload.to_json, {'Content-Type' => 'application/json'} 
    expect(last_response.status).to equal(201)
  end
  
  it "GET spec" do
    params1 = {'range' => [1460205600,1460205700]}
    get '/42', :json => params1.to_json
    puts last_response.body
    expect(JSON.parse(last_response.body)['min'].to_i).to equal(2)
    expect(JSON.parse(last_response.body)['avg'].to_i).to equal(3)
    expect(JSON.parse(last_response.body)['max'].to_i).to equal(4)  
  end  
   
  it "GET spec2" do     
    params2 = {'range' => [1460205600,1460205800]}
    get '/42', :json => params2.to_json
    expect(JSON.parse(last_response.body)['min'].to_i).to equal(2)
    expect(JSON.parse(last_response.body)['avg'].to_i).to equal(4)
    expect(JSON.parse(last_response.body)['max'].to_i).to equal(6)  
  end
  
end
