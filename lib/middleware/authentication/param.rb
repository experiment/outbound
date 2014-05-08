class Authentication::Param < Authentication::Base

  def authenticated?
    @req = Rack::Request.new @env

    authentication_param && param_matches?
  end

  private

    def authentication_param
      @req.params['authority']
    end

    def param_matches?
      authentication_param == ENV['AUTHENTICATION_HEADER']
    end
end
