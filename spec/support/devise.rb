# frozen_string_literal: true

require 'devise'

RSpec.configure do |config|
  # For Devise >= 4.1.0
  config.include Devise::Test::ControllerHelpers, type: :controller
  # Use the following instead if you are on Devise <= 4.1.1
  # config.include Devise::TestHelpers, :type => :controller
end
