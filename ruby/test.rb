ENV['RACK_ENV'] = 'test'
require 'minitest/autorun'
require 'rack/test'

require_relative 'simple_data_service.rb'

include Rack::Test::Methods

def app
  Sinatra::Application
end

describe "Simple Data Service" do

  it "should return json" do
    get '/data'
    last_response.headers['Content-Type'].must_equal 'application/json;charset=utf-8'
  end

end
