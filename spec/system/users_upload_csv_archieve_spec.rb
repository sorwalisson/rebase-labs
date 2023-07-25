require 'spec_helper'

describe 'Sinatra App' do
  it 'users go to /upload page and uploads an csv archieve' do
    visit '/upload'

    file = 'data.csv'

    attach_file('csv_file', file)
    click_on 'Upload'

    expect(current_path).to eq '/tests'
  end
end