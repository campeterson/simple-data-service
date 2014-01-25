require 'sinatra'
#require 'sinatra/synchrony' # http://stackoverflow.com/questions/8856001/sinatra-synchrony-with-redis-connection-pooling
require 'json'
require 'redis'

configure do
  @@redis_data_key = "data"
  @@redis = Redis.new
end

class SimpleDataService < Sinatra::Base
  #register Sinatra::Synchrony
  set :methodoverride, true

  helpers do
    def json_status(code, reason)
      status code
      {
        :status => code,
        :reason => reason
      }.to_json
    end

    def accept_params(params, *fields)
      h = { }
      fields.each do |name|
        h[name] = params[name] if params[name]
      end
      h
    end
  end

  post "/data/?", :provides => :json do
    content_type :json

    data = JSON.parse(request.body.read)

    if @@redis.rpush(@@redis_data_key, data)
      #headers["location"] = "/data/#{data.id}"
      # http://www.w3.org/protocols/rfc2616/rfc2616-sec9.html#sec9.5
      status 201 # created
      data.to_json
    else
      json_status 400, data.errors.to_hash
    end
  end

  # misc handlers
  get "*" do
    status 404
  end

  #put_or_post "*" do
    #status 404
  #end

  delete "*" do
    status 404
  end

  not_found do
    json_status 404, "Not found"
  end

  error do
    json_status 500, env['sinatra.error'].message
  end

end
