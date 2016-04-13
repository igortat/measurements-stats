# postdata.rb
require 'json'
require 'net/http'

@host = 'localhost'
@port = '9292'
@post_ws = "/1"

@payload ={
    "1460205648" => 10,
    "1460205658" => 11,
    "1460205668" => 12,
  }.to_json
  
def post
     req = Net::HTTP::Post.new(@post_ws, initheader = {'Content-Type' =>'application/json'})
          req.body = @payload
          response = Net::HTTP.new(@host, @port).start {|http| http.request(req) }
end

post
