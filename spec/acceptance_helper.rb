require 'rails_helper'  
require 'rspec_api_documentation'  
require 'rspec_api_documentation/dsl'

RspecApiDocumentation.configure do |config|
  # config.client_method = :client
  config.format = :api_blueprint
  config.request_body_formatter = :json
  config.request_headers_to_include = %w(Content-Type Accept Access-Token Token-Type Client Expiry Uid)
  config.response_headers_to_include = %w[Content-Type]
end  
