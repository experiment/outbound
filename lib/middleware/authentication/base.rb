module Authentication
  class Base

    def initialize(app)
      @app = app
    end

    def call(env)
      @env = env

      if authenticated?
        @app.call env
      else
        forbidden!
      end
    end

    private

      def authenticated?
        false
      end

      def forbidden!
        [403, {}, []]
      end
  end
end
