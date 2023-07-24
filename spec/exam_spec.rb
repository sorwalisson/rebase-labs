require 'spec_helper'
require 'pry'

RSpec.describe Exam do
  describe 'Check if the New method is working' do
    context 'When the data comes from JSON parsed from CSV' do
      it 'Returns true if the object is mounted and saved' do
        json = {"id":"1","cpf":"04897317088","nome paciente":"Emilly Batista Neto","email paciente":"gerald.crona@ebert-quigley.com","data nascimento paciente":"2001-03-11",
                "endereço/rua paciente":"165 Rua Rafaela","cidade paciente":"Ituverava","estado patiente":"Alagoas","crm médico":"B000BJ20J4","crm médico estado":"PI",
                "nome médico":"Maria Luiza Pires","email médico":"denna@wisozk.biz","token resultado exame":"IQCZ17","data exame":"2021-08-05","tipo exame":"hemácias",
                "limites tipo exame":"45-52","resultado tipo exame":"97"}
        novo_exame = Exam.new(json)
        novo_exame.save

        expect(novo_exame.name).to eq "Emilly Batista Neto"
        expect(Exam.count).to eq 1
      end

      it 'return true if the data base is cleaner after each example' do
        expect(Exam.count).to eq 0
      end
    end
  end
end

