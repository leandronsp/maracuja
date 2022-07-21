require 'sinatra'
require 'rack/handler/puma'
require './lib/csv_to_json'
require './lib/result_test_dao'
require './lib/importer'
require './lib/importer_job'

get '/tests.csv' do
  CsvToJson.call('./data.csv').map(&:to_json)
end

get '/tests' do
  ResultTestDAO.all
end

get '/import' do
  Importer.call('./data.csv')

  "Timestamp: #{SecureRandom.uuid}"
end

post '/import' do
  ImporterJob.perform_async('./data.csv')

  "Timestamp: #{SecureRandom.uuid}"
end

Rack::Handler::Puma.run(
  Sinatra::Application,
  Port: 3000,
  Host: '0.0.0.0'
)
