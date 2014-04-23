# Registered in config/initializers/email.rb

class RecordSendObserver

  def self.delivered_email(message)
    record_send! message
  end

  private

    def self.record_send!(message)
      return unless message._recipient_contact_id

      contact = Contact.find message._recipient_contact_id

      contact.emails.create do |email|
        email.method = message._mailer_method
        if message._version
          email.version = message._version
        end
      end
    end
end
