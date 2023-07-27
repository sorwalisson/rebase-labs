require 'spec_helper'


feature 'Users goes to /tests' do
  scenario 'and see form' do
    visit '/'
    click_on "Resultados de exames"

    expect(page).to have_content "Digite o Token:"
  end
end

