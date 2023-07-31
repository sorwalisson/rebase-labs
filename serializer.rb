require './apprecord'
require './exam'
require './doctor'
require './patient'

class Serializer
  def self.all_hash
    final_array = Array.new
    patients = Patient.all
    return "There is no exams yet!" if patients.nil?
    patients.each do |patient|
      patient_hash = patient.to_hash
      used_tokens = []
      patient_exams = []
      
      patient.exams.each do |exams|
        status = false
        if !used_tokens.include?(exams.exam_token)
          patient_exams << {"exam_token": exams.exam_token, "exam_date": exams.exam_date, "doctor": exams.doctor.to_hash.except("id"), "exams_array": []}
          used_tokens << exams.exam_token
        end
        patient_exams.last[:"exams_array"].each {|hash| if hash.key("id") == exams.id.to_s then status = true end} if !patient_exams.last[:"exams_array"].empty?
        patient_exams.last[:"exams_array"] << exams.to_hash.except("id", "exam_token", "exam_date", "patient_id", "doctor_id") if !status
      end
      final_hash = {"exams" => patient_exams}
      patient_hash = patient_hash.merge(final_hash)
      final_array << patient_hash
    end
    final_array
  end

  def self.by_token(token)
    exams = Exam.where(exam_token: token.upcase)
    return "Token not found" if exams.nil?
    exams_array = []
    exams.each {|exam| exams_array << exam.to_hash.except("id", "exam_token", "exam_date", "patient_id", "doctor_id")}
    exam_hash = {"exam_token": "#{token.upcase}", "exam_date": exams.first.exam_date, "doctor": exams.first.doctor.to_hash.except("id"), "results": exams_array}
    exams.first.patient.to_hash.merge(exam_hash)
  end

  def self.by_cpf(cpf)
    patient = Patient.find_by(cpf: cpf)
    return "CPF not found" if patient.nil?
    used_tokens = []
    exams_token = []
    patient.exams.each do |obj|
      exams_token << {"exam_date": obj.exam_date, "#{obj.exam_token}": []} unless used_tokens.include?("#{obj.exam_token}")
      exams_token.last[:"#{obj.exam_token}"] << obj.to_hash.except("id", "exam_token", "patient_id", "doctor_id")
      used_tokens << obj.exam_token unless used_tokens.include?(obj.exam_token)
    end
    final_hash = patient.to_hash.except("id").merge(exams: exams_token)
    final_hash
  end
end
