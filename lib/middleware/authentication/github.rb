class Authentication::Github < Authentication::Base

  private

    def authenticated?
      warden.authenticate! && user && user_in_organization?
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
