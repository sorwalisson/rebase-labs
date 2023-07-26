require './apprecord'
require './exam'
require './doctor'
require './patient'

class Serializer
  def self.all_hash
    final_array = Array.new 
    patients = Patient.all
    patients.each do |patient|
      patient_hash = patient.to_hash
      used_tokens = []
      patient.exams.each {|exams| used_tokens << exams.exam_token unless used_tokens.include?(exams.exam_token)}
      exams_hash = Hash.new
      used_tokens.each do |token|
        exams_array = []
        Exam.where(exam_token: token).each {|obj| exams_array << obj.to_hash}
        token_hash = {"#{token}": exams_array}
        exams_hash.merge!(token_hash)
      end
      patient_hash.merge!{exams_hash}
      final_array << patient_hash
    end
    final_array
  end
end