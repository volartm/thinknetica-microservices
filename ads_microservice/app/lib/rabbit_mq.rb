module RabbitMq
  extend self

  @mutex = Mutex.new

  def connection
    @mutex.synchronize do
      @connection ||= Bunny.new(connection_uri).start
    end
  end

  def channel
    @channel = Thread.current[:rabbitmq_channel] ||= connection.create_channel
  end

  def consumer_channel
    # See http://rubybunny.info/articles/concurrency.html#consumer_work_pools
    Thread.current[:rabbitmq_consumer_channel] ||=
      connection.create_channel(
        nil,
        Settings.rabbitmq.consumer_pool
      )
  end

  def connection_uri
    "amqp://#{user}:#{password}@#{hostname}:#{port}"
  end

  def user
    @user ||= ENV.fetch('RABBITMQ_DEFAULT_USER')
  end

  def password
    @password ||= ENV.fetch('RABBITMQ_DEFAULT_PASSWORD')
  end

  def hostname
    @hostname ||= ENV.fetch('RABBITMQ_HOST_NAME')
  end

  def port
    @port ||= ENV.fetch('RABBITMQ_PORT')
  end

  private :connection_uri, :password
end