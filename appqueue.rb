require 'redis'
require './exams_importer'
require 'sidekiq'

class AppQueue
  def self.newjob(json)
    ExamsImporter.perform_async(json)
    puts "new job added to queue"
  end
end