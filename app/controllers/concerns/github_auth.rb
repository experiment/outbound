module GithubAuth
  extend ActiveSupport::Concern

  included do
    prepend_before_filter :authenticate_with_github!
  end

  private

    def authenticate_with_github!
      unless warden.authenticate! && user && user_in_organization?
        head :forbidden
      end
    end

    def warden
      env['warden']
    end

    def user
      warden.user
    end

    def user_in_organization?
      user.organization_member? 'microryza'
    end
end
