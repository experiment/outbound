Sidekiq.configure_server do |config|
  config.redis = { namespace: 'outbound:sidekiq' }
end

Sidekiq.configure_client do |config|
  config.redis = { namespace: 'outbound:sidekiq' }
end
