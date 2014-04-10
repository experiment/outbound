# Registered in config/initializers/email.rb

class TagEmailInterceptor

  def self.previewing_email(mail)
    add_outbound_tag mail
  end

  def self.delivering_email(mail)
    add_outbound_tag mail
  end

  private

    def self.add_outbound_tag(mail)
      mail.header['X-MC-Tags'] = 'outbound'
    end
end
