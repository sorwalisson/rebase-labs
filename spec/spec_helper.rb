require 'rack/test'
require 'capybara/rspec'
require './server'
require './testemanager'

ENV['RACK_ENV'] = 'test'

Capybara.app = Sinatra::Application

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include Capybara::DSL

  config.after(:each) do 
    Testemanager.new.database_cleaner
  end
end
