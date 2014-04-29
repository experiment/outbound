class ApplicationController < ActionController::Base

  def home
    render layout: nil
  end
end
