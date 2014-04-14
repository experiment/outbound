class Mailer < ActionMailer::Base
  default to: Proc.new { to.email }

  protected

    def initialize(method_name = nil, *args)
      super

      # Record the email method in _mailer_method
      @_message._mailer_method = method_name

      # Record the recipient contact id
      @_message._recipient_contact_id = @contact.id
    end

    def mail(headers = {}, &block)
      # Don't allow to
      if headers.has_key? :to
        raise 'Not allowed to explicitly set to. Set @contact instead'
      end

      super
    end

  private

    def to
      if @contact
        @contact
      else
        raise 'Must specifiy @contact!'
      end
    end
end
