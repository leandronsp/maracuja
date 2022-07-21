require 'sinatra'
require 'rack/handler/puma'
require './lib/csv_to_json'
require './lib/database'
require './lib/importer'

get '/tests' do
  Database.tests
end

get '/import' do
  Importer.call('./data.csv')

  "Timestamp: #{SecureRandom.uuid}"
end

get '/tests.csv' do
  CsvToJson.call('./data.csv').map(&:to_json)
end

Rack::Handler::Puma.run(
  Sinatra::Application,
  Port: 3000,
  Host: '0.0.0.0'
)
