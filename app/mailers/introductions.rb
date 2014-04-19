class Introductions < Mailer

  def first_contact(contact_id, template = nil)
    @contact = Contact.find contact_id
    # Choose version unless specified in args
    template ||= %w(phone_call start_page).sample

    return false if @contact.emailed?

    ensure_contact_has_info :source, :url

    mail subject: "I saw your story in #{@contact.info[:source]}",
         template_name: template
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
