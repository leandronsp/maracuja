require 'sinatra'
require 'rack/handler/puma'
require 'csv'

get '/tests.csv' do
  CSV.read("./data.csv", col_sep: ';').map(&:to_json)
end

Rack::Handler::Puma.run(
  Sinatra::Application,
  Port: 3000,
  Host: '0.0.0.0'
)
