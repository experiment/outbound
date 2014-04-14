module Mail
  class Message
    # Add ivar for remembering which mailer method created
    # this message
    attr_accessor :_mailer_method
  end
end
