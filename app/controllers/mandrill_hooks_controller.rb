class MandrillHooksController < ApplicationController
  include Mandrill::Rails::WebHookProcessor

  authenticate_with_mandrill_keys! ENV['MANDRILL_WEBHOOK_KEY']

  def handle_open(payload)
    Rails.logger.info payload

    if payload['msg'] && payload['msg']['tags'].include?('outbound')
      record_open! payload['msg']['email'], Time.at(payload['ts'])
    end
  end

  def handle_inbound(payload)
    Rails.logger.info payload

    record_reply! payload['msg'], Time.at(payload['ts'])
  end

  private

    def record_open!(email, timestamp)
      puts "record_open! #{email} at #{timestamp}"
      if (contact = Contact.by_email(email).take)
        # TODO, presumes email opened was first_contact
        email = contact.emails.where(method: 'first_contact').take
        email.opened! timestamp
      end
    end

    def record_reply!(msg, timestamp)
      email = msg['from_email']
      Rails.logger.info "record_reply! [#{timestamp}] #{email}"


      if (contact = Contact.by_email(email).take)
        # TODO, presumes email opened was first_contact
        email = contact.emails.where(method: 'first_contact').take
        email.replied! timestamp
      end
    end
end
