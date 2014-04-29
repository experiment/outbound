class MandrillHooksController < ApplicationController
  include Mandrill::Rails::WebHookProcessor

  authenticate_with_mandrill_keys! ENV['MANDRILL_WEBHOOK_KEY']

  def handle_open(payload)
    Rails.logger.info payload
  end
end
