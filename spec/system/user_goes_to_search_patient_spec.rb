require 'spec_helper'

feature 'user goes to search patient page' do
  scenario 'and sees the form to search patient by cpf' do
    visit '/patients'

    expect(page).to have_content "Digite o CPF:"
    expect(page).to have_button "Pesquisar"
  end
end