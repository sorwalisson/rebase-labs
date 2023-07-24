require 'sinatra'
require 'rack/handler/puma'
require 'pg'
require 'csv'
require 'carrierwave'
require './exam'
require './dbmanager'

CarrierWave.configure do |config|
  config.root = File.join(__dir__, "uploads")
end

get '/tests' do
  data = Dbmanager.new.do_query("SELECT * FROM exams;")
  data.to_a.to_json
rescue PG::Error => e
  "Error: #{e.message}"
end

get '/hello' do
  'Hello world!'
end

get '/upload' do
  erb :upload_form
end

post '/upload' do
  rows = CSV.read(params[:csv_file][:tempfile], col_sep: ';')
  columns = rows.shift

  exams_json = rows.map do |row|
    row.each_with_object({}).with_index do |(cell, acc), idx|
      column = columns[idx]
      acc[column] = cell
    end
  end.to_json

  JSON.parse(exams_json).each do |obj|
    Exam.new(obj).save
  end

  redirect '/tests'

rescue PG::Error => e
  status 500
  body "Database Error: #{e.message}"
rescue StandardError => e
  status 500
  body "Error: #{e.message}"
end

Rack::Handler::Puma.run(
  Sinatra::Application,
  Port: 3000,
  Host: '0.0.0.0'
)