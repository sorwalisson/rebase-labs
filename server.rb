require 'sinatra'
require 'rack/handler/puma'
require 'pg'
require 'csv'
require 'carrierwave'
require './appqueue'
require './exam'
require './dbmanager'
require './serializer'

CarrierWave.configure do |config|
  config.root = File.join(__dir__, "uploads")
end

get '/api/tests' do
  Serializer.all_hash.to_json
rescue PG::Error => e
  "Error: #{e.message}"
end

get "/api/tests/:token" do
  Serializer.by_token(params[:token]).to_json
end

get '/' do
  erb :index
end

get '/upload' do
  erb :upload_form
end

get '/tests' do
  erb :test
end

post '/upload' do
  begin
    rows = CSV.read(params[:csv_file][:tempfile], col_sep: ';')
    columns = rows.shift

    exams_json = rows.map do |row|
      row.each_with_object({}).with_index do |(cell, acc), idx|
        column = columns[idx]
        acc[column] = cell
      end
    end.to_json

    AppQueue.newjob("import_csv", exams_json)

    content_type :json
    { message: 'Arquivo enviado com sucesso!' }.to_json
  rescue StandardError => e
    status 500
    content_type :json
    { error: 'Erro ao enviar o arquivo.' }.to_json
  end
end

Rack::Handler::Puma.run(
  Sinatra::Application,
  Port: 3000,
  Host: '0.0.0.0'
)