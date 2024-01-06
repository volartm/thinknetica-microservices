module RabbitMq
  extend self

  @mutex = Mutex.new

  def connection
    @mutex.synchronize do
      @connection ||= Bunny.new('amqp://guest:guest@rabbit1:5672').start
    end
  end

  def channel
    @channel = Thread.current[:rabbitmq_channel] ||= connection.create_channel
  end

  def connection_string
    'aa'
  end

  private :connection_string
end