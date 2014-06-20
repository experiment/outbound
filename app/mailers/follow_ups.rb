class FollowUps < Mailer

  def interested_first_follow_up(contact_id)
    @contact = Contact.find contact_id

    # TODO, record original subject and use that
    # so they don't drift apart
    subject = "Re: I saw your paper in #{@contact.info[:journal]}"

    mail subject: subject
  end

  def mass_follow_up(contact_id)
    @contact = Contact.find contact_id

    mail subject: "Re: I saw your paper in #{@contact.info[:journal]}"
  end
end
