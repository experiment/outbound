class Mailer < ActionMailer::Base

  protected

    def initialize(method_name=nil, *args)
      super

      # Record the email method in _mailer_method
      @_message._mailer_method = method_name
    end
end
