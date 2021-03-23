require 'spec_helper'

ENV['RACK_ENV'] ||= 'test'

require_relative '../config/environment'

# require 'pry'

# binding.pry
abort("You run this test #{ENV['RACK_ENV']} mode. RACK_ENV should be set to 'test'") unless Application.environment == :test

Dir[Application.root.concat('/spec/support/**/*.rb')].sort.each { |f| require f }

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include RouteHelpers, type: :routes
end
