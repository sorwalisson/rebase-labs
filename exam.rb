require './dbmanager'
class Exam < Dbmanager
  attr_accessor :cpf, :name, :email, :birthdate, :address, :city, :state, 
                :doctor_registration, :doctor_state_registration, :doctor_name, :doctor_email, :exam_token, :exam_date, :exam_type,
                :exam_ranges, :exam_results

  def initialize(data)
    @cpf = data["cpf"].gsub(/[-.]/, "")
    @name = data["nome paciente"]
    @email = data["email paciente"]
    @birthdate = Date.parse(data["data nascimento paciente"])
    @address = data["endereço/rua paciente"]
    @city = data["cidade paciente"].gsub("'", "")
    @state = data["estado patiente"]
    @doctor_registration = data["crm médico"]
    @doctor_state_registration = data["crm médico estado"]
    @doctor_name = data["nome médico"]
    @doctor_email = data["email médico"]
    @exam_token = data["token resultado exame"]
    @exam_date = Date.parse(data["data exame"])
    @exam_type = data["tipo exame"]
    @exam_ranges = data["limites tipo exame"]
    @exam_results = data["resultado tipo exame"]
  end

  def save
    dbmanager = Dbmanager.new
    insert_query = "INSERT INTO exams VALUES ('#{self.cpf}', '#{self.name}', '#{self.email}', '#{self.birthdate}', " \
                   "'#{self.address}', '#{self.city}', '#{self.state}', '#{self.doctor_registration}', '#{self.doctor_state_registration}', '#{self.doctor_name}', " \
                   "'#{self.doctor_email}', '#{self.exam_token}', '#{self.exam_date}', '#{self.exam_type}', '#{self.exam_ranges}', '#{self.exam_results}');"
    dbmanager.do_query(insert_query)
  end
end
