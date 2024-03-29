require 'spec_helper'


feature 'Users goes to api/tests' do
  scenario 'and sees json with patient and exams' do
    novo_medico = Doctor.new(doctor_registration: "B000BJ20J4", doctor_state_registration: "PI",
          doctor_name: "Maria Luiza Pires", doctor_email: "denna@wisozk.biz")
    novo_medico.save
    novo_paciente = Patient.new(cpf: "04897317088", name: "Emilly Batista Neto", email: "gerald.crona@ebert-quigley.com", birthdate: Date.parse("2001-03-11"),
         address: "165 Rua Rafaela",city: "Ituverava", state: "Alagoas")
    novo_paciente.save

    novo_exame = Exam.new(exam_token: "IQCZ17", exam_date: Date.parse("2021-08-05"), exam_type: "hemácias",
          exam_ranges: "45-52", exam_results:"97", patient_id: Patient.first.id, doctor_id: Doctor.first.id)
    novo_exame.save

    visit "/api/tests/#{novo_exame.exam_token}"

    expect(page).to have_content Serializer.by_token(novo_exame.exam_token).to_json
  end

  scenario 'and return not found when the token is not on the database' do
    visit 'api/tests/QKQ33321'

    expect(page).to have_content "Token not found"
  end
end