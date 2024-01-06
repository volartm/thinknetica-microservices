require 'bunny'

class Consumer
  def initialize(queue:)
    @connection = Bunny.new('amqp://rabbitmq:rabbitmq@rabbit1:5672').start
    @channel =@connection.create_channel
    @queue = @channel.queue(queue)
  end

  def start
    @queue.subscribe do |delivery_info, properties, payload|
      puts "Recieved: #{payload}"
    end
  end
end

Consumer.new(queue: 'tasks').start
puts 'Consumer started'

loop { sleep 3 }

