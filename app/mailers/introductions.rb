class Introductions < Mailer
  default from: 'oscarj@experiment.com'

  def first_contact(contact_id)
    @contact = Contact.find contact_id

    mail subject: "I saw your story in #{@contact.source}"
  end
end
