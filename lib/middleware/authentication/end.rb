class Authentication::End < Authentication::Base

  # Final authentication middleware
  # If no authentication middleware has marked the request as authenticated
  # returns a 403

  def initialize(app)
    @app = app
  end

  def call(env)
    if env['authenticated']
      @app.call env
    else
      forbidden!
    end
  end

  private

    def forbidden!
      [403, {}, []]
    end
end
