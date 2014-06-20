class FollowUps < Mailer

  def interested_first_follow_up(contact_id)
    @contact = Contact.find contact_id

    mail subject: "Re: #{original_subject @contact}"
  end

  def mass_follow_up(contact_id)
    @contact = Contact.find contact_id

    mail subject: "Re: #{original_subject @contact}"
  end

  private

    def original_subject(contact)
      # TODO, record original subject and use that
      # so they don't drift apart
      if contact.info.has_key? :journal
        "I saw your paper in #{contact.info[:journal]}"
      elsif contact.info.has_key? :source
        "I saw your story in #{contact.info[:source]}"
      else
        raise 'Unknown original subject'
      end
    end
end
