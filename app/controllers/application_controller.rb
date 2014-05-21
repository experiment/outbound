class ApplicationController < ActionController::Base

  def home
    @dates = Email.where(method: 'first_contact')
      .select("DISTINCT DATE_TRUNC('day', created_at) AS created_at")
      .map(&:created_at).sort
    # render layout: nil
  end

  def batch
    @date = Date.parse(params[:date])
    @emails = Email.on_date(@date).includes(:contact)
  end
end
