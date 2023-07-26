require 'redis'
require 'pry'

class AppQueue
  def self.newjob(queue, job)
    redis = Redis.new(host: 'redis', port: 6379)
    redis.rpush(queue, job)
    puts "New Job to Queue"
  end
end