require 'sidekiq-scheduler'

class ServiceWorker
  include Sidekiq::Worker

  def perform
    puts 'Hello world'
  end
end
# hello-scheduler.rb

# require 'sidekiq-scheduler'

# class HelloWorld
#   include Sidekiq::Worker

#   def perform
#     puts 'Hello world'
#   end
# end
