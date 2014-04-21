if Rails.env.production? || ENV['GITHUB_CLIENT_ID']

  Rails.application.config.middleware.use Warden::Manager do |config|
    config.default_strategies :github
    config.scope_defaults :default, config: { scope: 'read:org' }
  end

  Rails.application.config.middleware.insert_after Warden::Manager, GithubAuth

end
