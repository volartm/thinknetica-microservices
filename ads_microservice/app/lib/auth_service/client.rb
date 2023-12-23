require 'dry/initializer'

module AuthService
  class Client
    extend Dry::Initializer

    option :url, default: proc { 'http:localhost:3010/v1'}
    option :connection, default: proc { build_connection }

    def build_connection
      Faradey.new(@url) do |conn|
        conn.request :json
        conn.adapter Faradey.default_adapter
      end
    end
  end
end