require './apprecord'

class Doctor < AppRecord
  attr_accessor :id, :doctor_registration, :doctor_state_registration, :doctor_name, :doctor_email

  def initialize(data)
    @id = data[:id].to_i
    @doctor_registration = data[:doctor_registration]
    @doctor_state_registration = data[:doctor_state_registration]
    @doctor_name = data[:doctor_name]
    @doctor_email = data[:doctor_email]
  end

  def exams
    Exam.where(doctor_id: self.id)
  end
end