require 'spec_helper'


feature 'Users goes to /tests' do
  scenario 'and see form' do
    visit '/'

    expect(page).to have_link "Resultados de exames"
    expect(page).to have_link "Fazer upload de novo arquivo CSV"
  end
end
