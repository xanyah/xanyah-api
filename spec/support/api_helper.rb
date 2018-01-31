module ApiHelper  
  include Rack::Test::Methods
end 

RSpec.configure do |config|  
  config.include ApiHelper, type: :api
end
