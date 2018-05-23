# frozen_string_literal: true

Devise.setup do |config|
  config.mailer_sender = ENV['SMTP_FROM']
end
