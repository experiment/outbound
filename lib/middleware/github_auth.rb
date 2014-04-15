class GithubAuth
  def initialize(app)
    @app = app
  end

  def call(env)
    @env = env

    if authenticated_with_github?
      @app.call env
    else
      forbidden!
    end
  end

  private

    def authenticated_with_github?
      warden.authenticate! && user && user_in_organization?
    end

    def forbidden!
      [403, {}, []]
    end

    def warden
      @env['warden']
    end

    def user
      warden.user
    end

    def user_in_organization?
      user.organization_member? 'microryza'
    end
end
