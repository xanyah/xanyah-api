# frozen_string_literal: true

Sidekiq.configure_client do |config|
  config.redis = {namespace: 'Xanyah'}
end

Sidekiq.configure_server do |config|
  config.redis = {namespace: 'Xanyah'}
end
