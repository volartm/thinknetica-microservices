require_relative 'config/environment'

use Rack::Deflater

run proc { [200, { 'Content-Type' => 'text/html' }, ['OK']] }