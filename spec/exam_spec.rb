require 'spec_helper'
require 'pry'

RSpec.describe Exam do
  describe 'Check if the New method is working' do
    context 'When the data comes from JSON parsed from CSV' do
      it 'should return true if data saved' do
        novo_medico = Doctor.new(doctor_registration: "B000BJ20J4", doctor_state_registration: "PI",
                                 doctor_name: "Maria Luiza Pires", doctor_email: "denna@wisozk.biz")
        novo_medico.save
        novo_paciente = Patient.new(cpf: "04897317088", name: "Emilly Batista Neto", email: "gerald.crona@ebert-quigley.com", birthdate: Date.parse("2001-03-11"),
                                    address: "165 Rua Rafaela",city: "Ituverava", state: "Alagoas")
        novo_paciente.save

        novo_exame = Exam.new(exam_token: "IQCZ17", exam_date: Date.parse("2021-08-05"), exam_type: "hemácias",
                              exam_ranges: "45-52", exam_results:"97", patient_id: Patient.first.id, doctor_id: Doctor.first.id)
        novo_exame.save

        expect(novo_exame.exam_type).to eq "hemácias"
        expect(Exam.count).to eq 1
      end

      it 'return true if the data base is cleaned after each example' do
        expect(Exam.count).to eq 0
      end
    end

    context 'when the data comes from the database' do
      it 'it returns true if the query worked and returned an object' do
        novo_medico = Doctor.new(doctor_registration: "B000BJ20J4", doctor_state_registration: "PI",
                                 doctor_name: "Maria Luiza Pires", doctor_email: "denna@wisozk.biz")
        novo_medico.save
        novo_paciente = Patient.new(cpf: "04897317088", name: "Emilly Batista Neto", email: "gerald.crona@ebert-quigley.com", birthdate: Date.parse("2001-03-11"),
                                    address: "165 Rua Rafaela",city: "Ituverava", state: "Alagoas")
        novo_paciente.save

        novo_exame = Exam.new(exam_token: "IQCZ17", exam_date: Date.parse("2021-08-05"), exam_type: "hemácias",
                              exam_ranges: "45-52", exam_results:"97", patient_id: Patient.first.id, doctor_id: Doctor.first.id)
        novo_exame.save

        exame_db = Exam.where(exam_token: novo_exame.exam_token)

        expect(exame_db.first.exam_token).to eq novo_exame.exam_token
        expect(exame_db.first.exam_type).to eq novo_exame.exam_type
      end

      it 'returns true if it works for multiple ojects' do
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

        exames_db = Exam.where(exam_token: "IQCZ17")

        expect(exames_db.count).to eq 3
        expect(Exam.count).to eq 3
        expect(exames_db.first.id).to_not eq exames_db.last.id
      end
    end
  end

  describe 'verify if the method find_by is working' do
    it 'it returns true if the method is working' do
      novo_medico = Doctor.new(doctor_registration: "B000BJ20J4", doctor_state_registration: "PI",
                                 doctor_name: "Maria Luiza Pires", doctor_email: "denna@wisozk.biz")
      novo_medico.save
      novo_paciente = Patient.new(cpf: "04897317088", name: "Emilly Batista Neto", email: "gerald.crona@ebert-quigley.com", birthdate: Date.parse("2001-03-11"),
                                    address: "165 Rua Rafaela",city: "Ituverava", state: "Alagoas")
      novo_paciente.save

      novo_exame = Exam.new(exam_token: "IQCZ17", exam_date: Date.parse("2021-08-05"), exam_type: "hemácias",
                              exam_ranges: "45-52", exam_results:"97", patient_id: Patient.first.id, doctor_id: Doctor.first.id)
      novo_exame.save

      expect(Exam.first.patient.name).to eq "Emilly Batista Neto"
      expect(Exam.first.doctor.doctor_name).to eq "Maria Luiza Pires"
    end
  end
end

