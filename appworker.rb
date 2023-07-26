require 'redis'
require './exam'
require './patient'
require './doctor'
require 'json'
require 'date'

redis = Redis.new(host: 'redis', port: 6379)
loop do
  puts "awaiting job"
  newjob = redis.blpop("import_csv").last

  if newjob
    puts "Worker Started Working"
    new_exams = []
    patient_placeholder = nil
    doctor_placeholder = nil
    JSON.parse(newjob).each do |obj|
      if patient_placeholder == nil or patient_placeholder.cpf != obj["cpf"].gsub(/[-.]/, "")
        Patient.new(cpf: obj["cpf"].gsub(/[-.]/, ""), name: obj["nome paciente"], email: obj["email paciente"], birthdate: Date.parse(obj["data nascimento paciente"]), 
                      address: obj["endereço/rua paciente"], city: obj["cidade paciente"].gsub("'", ""), state: obj["estado patiente"]).save if !Patient.find_by(cpf: obj["cpf"].gsub(/[-.]/, ""))
        patient_placeholder = Patient.find_by(cpf: obj["cpf"].gsub(/[-.]/, ""))
      end
      if doctor_placeholder == nil or doctor_placeholder.doctor_registration != obj["crm médico"]
        Doctor.new(doctor_registration: obj["crm médico"], doctor_state_registration: obj["crm médico estado"], doctor_name: obj["nome médico"], 
                      doctor_email: obj["email médico"]).save if !Doctor.find_by(doctor_registration: obj["crm médico"])
        doctor_placeholder = Doctor.find_by(doctor_registration: obj["crm médico"])
      end
      new_exams << Exam.new(exam_token: obj["token resultado exame"], exam_date: Date.parse(obj["data exame"]), exam_type: obj["tipo exame"], exam_ranges: obj["limites tipo exame"], 
                      exam_results: obj["resultado tipo exame"], patient_id: patient_placeholder.id, doctor_id: doctor_placeholder.id)
    end
    Exam.array_save(new_exams)

    puts "Worker Finished Work"
  end
end