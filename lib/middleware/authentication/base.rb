module Authentication
  class Base

    # Base authentication middleware
    # Once a middlewares #authenticated? returns true
    # the request is considered authenticated and futher
    # #authenticated?s won't be called

    def initialize(app)
      @app = app
    end

    def call(env)
      @env = env

      authenticate!

      @app.call env
    end

    private

      def authenticate!
        if @env['authenticated']
          # Previously authenticated, carry on
          true
        elsif authenticated?
          # This middleware has authenticated,
          # mark request as authenticated
          @env['authenticated'] = true
          # And carry on
          true
        else
          false
        end
      end
  end
end
