if Rails.env.production?

  Rails.application.config.middleware.use Warden::Manager do |config|
    config.default_strategies :github
    config.scope_defaults :default, config: { scope: 'read:org' }
  end

end
