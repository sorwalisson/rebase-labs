require './dbmanager'
require 'pry'
class Exam < Dbmanager
  attr_accessor :cpf, :name, :email, :birthdate, :address, :city, :state, 
                :doctor_registration, :doctor_state_registration, :doctor_name, :doctor_email, :exam_token, :exam_date, :exam_type,
                :exam_ranges, :exam_results

  def initialize(data)
    if data.has_key?(:"nome paciente")
      @cpf = data[:"cpf"].gsub(/[-.]/, "")
      @name = data[:"nome paciente"]
      @email = data[:"email paciente"]
      @birthdate = Date.parse(data[:"data nascimento paciente"])
      @address = data[:"endereço/rua paciente"]
      @city = data[:"cidade paciente"].gsub("'", "")
      @state = data[:"estado patiente"]
      @doctor_registration = data[:"crm médico"]
      @doctor_state_registration = data[:"crm médico estado"]
      @doctor_name = data[:"nome médico"]
      @doctor_email = data[:"email médico"]
      @exam_token = data[:"token resultado exame"]
      @exam_date = Date.parse(data[:"data exame"])
      @exam_type = data[:"tipo exame"]
      @exam_ranges = data[:"limites tipo exame"]
      @exam_results = data[:"resultado tipo exame"]
    elsif data.has_key?(:name)
      @cpf = data[:cpf]
      @name = data[:name]
      @email = data[:email]
      @birthdate = data[:birthdate]
      @address = data[:address]
      @city = data[:city]
      @state = data[:state]
      @doctor_registration = data[:doctor_registration]
      @doctor_state_registration = data[:doctor_state_registration]
      @doctor_name = data[:doctor_name]
      @doctor_email = data[:doctor_email]
      @exam_token = data[:exam_token]
      @exam_date = data[:exam_date]
      @exam_type = data[:exam_type]
      @exam_ranges = data[:exam_ranges]
      @exam_results = data[:exam_results]  
    end
  end

  def save
    dbmanager = Dbmanager.new
    insert_query = "INSERT INTO exams (cpf, name, email, birthdate, address, city, state, doctor_registration, doctor_state_registration, doctor_name, doctor_email, exam_token, exam_date, exam_type, exam_ranges, exam_results) VALUES ('#{self.cpf}', '#{self.name}', '#{self.email}', '#{self.birthdate}', " \
                   "'#{self.address}', '#{self.city}', '#{self.state}', '#{self.doctor_registration}', '#{self.doctor_state_registration}', '#{self.doctor_name}', " \
                   "'#{self.doctor_email}', '#{self.exam_token}', '#{self.exam_date}', '#{self.exam_type}', '#{self.exam_ranges}', '#{self.exam_results}');"
    dbmanager.do_query(insert_query)
  end

  def self.count
    carrier = Dbmanager.new
    count_query = "SELECT COUNT(*) FROM exams;"
    query_result = carrier.do_query(count_query)
    query_result.values.first.first.to_i
  end
end
