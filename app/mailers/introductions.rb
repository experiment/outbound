class Introductions < Mailer

  def neuroscience(contact_id)
    @contact = Contact.find contact_id

    ensure_contact_has_info :source, :url

    mail subject: "I saw your story in #{@contact.info[:source]}"
  end

  private

    def ensure_contact_has_info(*keys)
      keys.each do |key|
        unless @contact.info.has_key? key
          raise "Contact info must have a #{key}"
        end
      end
    end
end
