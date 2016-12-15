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

  rescue_from Grape::Exceptions::ValidationErrors do |e|
    error!(e, 400)
  end

  mount Microservices::Messages
  mount Microservices::Ping
  mount Microservices::Rooms

  add_swagger_documentation info: {
    title: "Message Broadcasting API",
    description: "Grape-powered REST API.",
    contact_email: "leafmind@gmail.com",
    contact_url: "https://ancient-shelf-98201.herokuapp.com"
  }

  route :any, '*path' do
    error!('404 Not Found', 404)
  end
end
