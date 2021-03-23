require_relative 'config/environment'

# app = -> (env) { [200, { 'Content-type' => 'text/plain' }, []] }

map '/ads' do
  run AdRoutes
end