require 'spec_helper'

describe 'Sinatra App' do
  it 'displays the hello world message' do
    visit '/hello'
    expect(page).to have_content 'Hello world!'
  end
end