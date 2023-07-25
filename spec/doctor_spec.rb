require 'spec_helper'
require 'pry'

RSpec.describe Doctor do
  describe 'Check if the New method is working' do
    context 'When the data comes from JSON parsed from CSV' do
      it 'Returns true if the object is mounted and saved' do
        novo_medico = Doctor.new(doctor_registration: "B000BJ20J4", doctor_state_registration: "PI",
                                 doctor_name: "Maria Luiza Pires", doctor_email: "denna@wisozk.biz")
        novo_medico.save

        expect(novo_medico.doctor_name).to eq "Maria Luiza Pires"
        expect(Doctor.count).to eq 1
        expect(Doctor.first.doctor_name).to eq "Maria Luiza Pires"
      end

      it 'return true if the data base is cleaned after each example' do
        expect(Doctor.count).to eq 0
      end
    end
  end

  describe 'Check if the method .exams is working' do
    it 'it should return true if the method is working' do
      novo_medico = Doctor.new(doctor_registration: "B000BJ20J4", doctor_state_registration: "PI",
                               doctor_name: "Maria Luiza Pires", doctor_email: "denna@wisozk.biz")
      novo_medico.save
      novo_paciente = Patient.new(cpf: "04897317088", name: "Emilly Batista Neto", email: "gerald.crona@ebert-quigley.com", birthdate: Date.parse("2001-03-11"),
                                  address: "165 Rua Rafaela",city: "Ituverava", state: "Alagoas")
      novo_paciente.save
      Exam.new(exam_token: "IQCZ17", exam_date: Date.parse("2021-08-05"), exam_type: "hemácias",
                exam_ranges: "45-52", exam_results:"97", patient_id: Patient.first.id, doctor_id: Doctor.first.id).save
      Exam.new(exam_token: "IQCZ17", exam_date: Date.parse("2021-08-05"), exam_type: "plaquetas",
                exam_ranges: "90-122", exam_results:"100", patient_id: Patient.first.id, doctor_id: Doctor.first.id).save
      Exam.new(exam_token: "IQCZ17", exam_date: Date.parse("2021-08-05"), exam_type: "linfocitos",
                exam_ranges: "50-80", exam_results:"70", patient_id: Patient.first.id, doctor_id: Doctor.first.id).save
      expect(Doctor.first.exams.count).to eq 3
    end
  end
end