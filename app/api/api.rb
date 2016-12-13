require 'grape-swagger'

# @version 0.0.1 
class API < Grape::API
  prefix 'api'
  version 'v1', using: :path
  format :json

  helpers Microservices::Helpers

  rescue_from Grape::Exceptions::Base do |e|       
    error! e.message, e.status, e.headers     
  end

  mount Microservices::Messages
  mount Microservices::Ping
  mount Microservices::Rooms

  add_swagger_documentation

  route :any, '*path' do
    error!('404 Not Found', 404)
  end
end
