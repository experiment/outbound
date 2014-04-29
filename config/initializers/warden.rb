if Rails.env.production? || ENV['GITHUB_CLIENT_ID']

  authentication_middleware = [
    Authentication::Header,
    Authentication::Github
  ]

  Rails.application.config.middleware.use Warden::Manager do |config|
    config.default_strategies :github
    config.scope_defaults :default, config: { scope: 'read:org' }
  end

  # Middleware to check that some authentication succeeded
  Rails.application.config.middleware.insert_after Warden::Manager,
    Authentication::End

  # Insert authentication middleware
  # Reversing array so they are called in original order
  authentication_middleware.reverse.each do |middleware|
    Rails.application.config.middleware.insert_after Warden::Manager, middleware
  end

end
