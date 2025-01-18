# frozen_string_literal: true

Devise.setup do |config|
  config.mailer_sender = ENV.fetch('SMTP_FROM', nil)
end
