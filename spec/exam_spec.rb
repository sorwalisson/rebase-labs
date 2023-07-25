require 'spec_helper'
require 'pry'

RSpec.describe Exam do
  describe 'Check if the New method is working' do
    context 'When the data comes from JSON parsed from CSV' do
      it 'Returns true if the object is mounted and saved' do
        json = {"cpf":"04897317088","nome paciente":"Emilly Batista Neto","email paciente":"gerald.crona@ebert-quigley.com","data nascimento paciente":"2001-03-11",
                "endereço/rua paciente":"165 Rua Rafaela","cidade paciente":"Ituverava","estado patiente":"Alagoas","crm médico":"B000BJ20J4","crm médico estado":"PI",
                "nome médico":"Maria Luiza Pires","email médico":"denna@wisozk.biz","token resultado exame":"IQCZ17","data exame":"2021-08-05","tipo exame":"hemácias",
                "limites tipo exame":"45-52","resultado tipo exame":"97"}
        novo_exame = Exam.new(json)
        novo_exame.save

        expect(novo_exame.name).to eq "Emilly Batista Neto"
        expect(Exam.count).to eq 1
      end

      it 'return true if the data base is cleaned after each example' do
        expect(Exam.count).to eq 0
      end
    end

    context 'when the data comes from the database' do
      it 'it returns true if the query worked and returned an object' do
        json = {"id":"1","cpf":"04897317088","nome paciente":"Emilly Batista Neto","email paciente":"gerald.crona@ebert-quigley.com","data nascimento paciente":"2001-03-11",
          "endereço/rua paciente":"165 Rua Rafaela","cidade paciente":"Ituverava","estado patiente":"Alagoas","crm médico":"B000BJ20J4","crm médico estado":"PI",
          "nome médico":"Maria Luiza Pires","email médico":"denna@wisozk.biz","token resultado exame":"IQCZ17","data exame":"2021-08-05","tipo exame":"hemácias",
          "limites tipo exame":"45-52","resultado tipo exame":"97"}
        novo_exame = Exam.new(json)
        novo_exame.save

        exame_db = Exam.where(exam_token: novo_exame.exam_token)

        expect(exame_db.first.exam_token).to eq novo_exame.exam_token
        expect(exame_db.first.name).to eq novo_exame.name
      end

      it 'returns true if it works for multiple ojects' do
        json = [{
                  "cpf":"04897317088","nome paciente":"Emilly Batista Neto","email paciente":"gerald.crona@ebert-quigley.com","data nascimento paciente":"2001-03-11",
                  "endereço/rua paciente":"165 Rua Rafaela","cidade paciente":"Ituverava","estado patiente":"Alagoas","crm médico":"B000BJ20J4","crm médico estado":"PI",
                  "nome médico":"Maria Luiza Pires","email médico":"denna@wisozk.biz","token resultado exame":"IQCZ17","data exame":"2021-08-05","tipo exame":"hemácias",
                  "limites tipo exame":"45-52","resultado tipo exame":"97"},
                {
                  "cpf":"04897317088","nome paciente":"Emilly Batista Neto","email paciente":"gerald.crona@ebert-quigley.com","data nascimento paciente":"2001-03-11",
                  "endereço/rua paciente":"165 Rua Rafaela","cidade paciente":"Ituverava","estado patiente":"Alagoas","crm médico":"B000BJ20J4","crm médico estado":"PI",
                  "nome médico":"Maria Luiza Pires","email médico":"denna@wisozk.biz","token resultado exame":"IQCZ17","data exame":"2021-08-05","tipo exame":"plaquetas",
                  "limites tipo exame":"90-122","resultado tipo exame":"100"
                },
                {
                  "cpf":"04897317088","nome paciente":"Emilly Batista Neto","email paciente":"gerald.crona@ebert-quigley.com","data nascimento paciente":"2001-03-11",
                  "endereço/rua paciente":"165 Rua Rafaela","cidade paciente":"Ituverava","estado patiente":"Alagoas","crm médico":"B000BJ20J4","crm médico estado":"PI",
                  "nome médico":"Maria Luiza Pires","email médico":"denna@wisozk.biz","token resultado exame":"IQCZ17","data exame":"2021-08-05","tipo exame":"linfocitos",
                  "limites tipo exame":"50-80","resultado tipo exame":"70"}]
      
        json.each {|obj| Exam.new(obj).save}
        
        exames_db = Exam.where(exam_token: "IQCZ17")

        expect(exames_db.count).to eq 3
        expect(Exam.count).to eq 3
        expect(exames_db.first.id).to_not eq exames_db.last.id
      end
    end
  end
end

