require 'spec_helper'

ENV['RAKE_ENV'] ||= 'test'

require_relative '../config/environment'

abort('You run test in production mode. Please don\'t do this') if Application.environment == :production
Dir[Application.root.concat('/spec/support/**/*.rb')].sort.each { |f| require f }

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include RouteHelpers, type: :routes
  config.include ClientHelpers, type: :client
end