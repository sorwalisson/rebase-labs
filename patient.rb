require './apprecord'

class Patient < AppRecord
  attr_accessor :id, :cpf, :name, :email, :birthdate, :address, :city, :state

  def initialize(data)
    @id = data[:id].to_i
    @cpf = data[:cpf]
    @name = data[:name]
    @email = data[:email]
    @birthdate = data[:birthdate]
    @address = data[:address]
    @city = data[:city]
    @state = data[:state]
  end

  def exams
    Exam.where(patient_id: self.id)
  end
end