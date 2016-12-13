GrapeSwaggerRails.options.url      = '/api/v1/swagger_doc.json'
GrapeSwaggerRails.options.app_url  = 'http://localhost:3000'

GrapeSwaggerRails.options.api_key_name = 'user_token'
GrapeSwaggerRails.options.api_key_type = 'query'

GrapeSwaggerRails.options.api_key_default_value = 'debug-user-token'

#GrapeSwaggerRails.options.before_action do
#  GrapeSwaggerRails.options.app_url = request.protocol + request.host_with_port
#end