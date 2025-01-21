# frozen_string_literal: true

require 'rails_helper'
require 'rspec_api_documentation'
require 'rspec_api_documentation/dsl'

RspecApiDocumentation.configure do |config|
  # config.client_method = :client
  config.docs_dir = Rails.root.join('docs/api')
  config.api_explanation = Rails.root.join('docs/README.md').read
  config.format = :open_api
  config.request_body_formatter = :json
  config.request_headers_to_include = %w[Content-Type Accept Access-Token Token-Type Client Expiry Uid]
  config.response_headers_to_include = %w[Content-Type Accept Access-Token Token-Type Client Expiry Uid]
end

module RspecApiDocumentation
  class RackTestClient < ClientBase
    def response_body
      last_response.body.encode('utf-8')
    end
  end
end
