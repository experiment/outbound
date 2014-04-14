class Introductions < Mailer

  def first_contact(contact_id)
    @contact = Contact.find contact_id

    mail subject: "I saw your story in #{@contact.source}"
  end
end
