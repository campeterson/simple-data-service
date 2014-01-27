# Simple Data Service

## Clojure
Coming soon.

## Ruby
An adaptation from: https://github.com/bbcrd/REST-API-example

### Getting Started

Dependencies

- Ruby 1.9+
- Redis must be installed

Start Redis
    redis-server

Clone Repo
    git clone git@github.com:campeterson/simple-data-service.git

Bundle Gems
    cd simple-data-service/ruby
    bundle install

Start the server
    bundle exec rackup

Start sending data
    curl -i -H "Content-Type: application/json" -H "Accept: application/json" -X POST -d '{"person":{"name":"bob", "created_at": 1390838634}}' http://localhost:9292/data/

### Benchmark test
     ab -n 1000 -c 10 -p sample.json -T "application/json; charset=utf-8" http://localhost:9292/data/
