class Introductions < Mailer

  def first_contact(contact_id, template = nil)
    @contact = Contact.find contact_id
    # # Choose version unless specified in args
    # template ||= %w(phone_call start_page).sample
    template ||= 'phone_call'

    return false if @contact.emailed?

    ensure_contact_has_info :journal, :paper

    @published_at = @contact.info[:paper][:published_at].to_date

    @keyword = case @contact.info[:journal]
      when 'BMC Neuroscience', 'BMC Psychology', 'Behavioral and Brain Functions'
        'neuroscience & psychology'
      when 'BMC Cancer'
        'cancer'
      when 'BMC Evolutionary Biology', 'BMC Plant Biology', 'PLOS Biology', 'PLOS Computational Biology'
        'biology'
      when 'BMC Pediatrics'
        'pediatric'
      else
        raise "No keyword for this journal (#{@contact.info[:journal]})"
    end

    mail subject: "I saw your paper in #{@contact.info[:journal]}",
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
