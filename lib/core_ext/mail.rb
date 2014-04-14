module Mail
  class Message
    # ivar for remembering which mailer method created this message
    attr_accessor :_mailer_method

    # ivar for the contact id of the recipient
    attr_accessor :_recipient_contact_id
  end
end
