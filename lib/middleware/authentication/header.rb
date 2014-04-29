class Authentication::Header < Authentication::Base

  def authenticated?
    authentication_header && header_matches?
  end

  private

    def authentication_header
      @env['HTTP_AUTHENTICATION_HEADER']
    end

    def header_matches?
      authentication_header == ENV['AUTHENTICATION_HEADER']
    end
end
