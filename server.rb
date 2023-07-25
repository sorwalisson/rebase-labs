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
    if Patient.find_by(cpf: obj[:"cpf"].gsub(/[-.]/, "")).nil?
      Patient.new(cpf: obj[:"cpf"].gsub(/[-.]/, ""), name: obj[:"nome paciente"], email: obj[:"email paciente"], birthdate: Date.parse(obj[:"data nascimento paciente"]), 
                  address: obj[:"endereço/rua paciente"], city: obj[:"cidade paciente"].gsub("'", ""), state: obj[:"estado patiente"]).save
      patient = Patient.find_by(cpf: obj[:"cpf"].gsub(/[-.]/, ""))
    else
      patient = Patient.find_by(cpf: obj[:"cpf"].gsub(/[-.]/, ""))
    end
    if Doctor.find_by(doctor_registration: obj[:"crm médico"]).nil?
      Doctor.new(doctor_registration: obj[:"crm médico"], doctor_state_registration: obj[:"crm médico estado"], doctor_name: obj[:"nome médico"], 
                 doctor_email: obj[:"email médico"]).save
      doctor = Doctor.find_by(doctor_registration: obj[:"crm médico"])
    else
      doctor = Doctor.find_by(doctor_registration: obj[:"crm médico"])
    end
    Exam.new(exam_token: obj[:"token resultado exame"], exam_date: Date.parse(obj[:"data exame"]), exam_type: obj[:"tipo exame"], exam_ranges: obj[:"limites tipo exame"], 
      exam_results: obj[:"resultado tipo exame"], patient_id: patient.id, doctor_id: doctor.id).save
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