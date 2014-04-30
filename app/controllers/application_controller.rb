class ApplicationController < ActionController::Base

  def home
    @dates = Email.select("DISTINCT DATE_TRUNC('day', created_at) AS created_at").map(&:created_at)
    render layout: nil
  end
end
