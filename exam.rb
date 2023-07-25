require './apprecord'
require 'pry'
class Exam < AppRecord
  attr_accessor :id, :exam_token, :exam_date, :exam_type, :exam_ranges, :exam_results, :patient_id, :doctor_id

  def initialize(data)
    @id = data[:id].to_i 
    @exam_token = data[:exam_token]
    @exam_date = data[:exam_date]
    @exam_type = data[:exam_type]
    @exam_ranges = data[:exam_ranges]
    @exam_results = data[:exam_results] 
    @patient_id = data[:patient_id]
    @doctor_id = data[:doctor_id]
  end

  def patient
    Patient.find_by(id: self.patient_id)
  end

  def doctor
    Doctor.find_by(id: self.doctor_id)
  end
end
