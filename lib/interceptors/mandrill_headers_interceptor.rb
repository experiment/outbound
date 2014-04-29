# Registered in config/initializers/email.rb

class MandrillHeadersInterceptor

  def self.previewing_email(mail)
    add_mandrill_headers mail
  end

  def self.delivering_email(mail)
    add_mandrill_headers mail
  end

  private

    def self.add_mandrill_headers(mail)
      # Create HTML versions of plain text emails
      mail.header['X-MC-AutoHtml'] = true

      # Add open tracking pixel
      mail.header['X-MC-Track'] = 'opens'
    end
end
