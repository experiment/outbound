class ApplicationController < ActionController::Base
  include GithubAuth if Rails.env.production?

  protect_from_forgery with: :exception

  def home
    render layout: nil
  end
end
