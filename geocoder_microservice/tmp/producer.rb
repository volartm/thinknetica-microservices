require 'bunny'

class Producer
  def initialize(queue:)
    @connection = Bunny.new('amqp://rabbitmq:rabbitmq@rabbit1:5672').start
    @channel = @connection.create_channel
    @queue = @channel.queue(queue)
  end

  def publish(payload)
    @channel.default_exchange.publish(payload, routing_key: @queue.name)
  ensure 
    @connection.close
  end
end

Producer.new(queue: 'tasks').publish('payload')
