class Introductions < Mailer

  def first_contact(contact_id)
    @contact = Contact.find contact_id

    return false if @contact.emailed?

    case @contact.source
      when 'filofax'
        first_contact_journal
      when 'manual'
        first_contact_manual
      when 'institution_manual'
        first_contact_institution_manual
      else
        raise 'No template for this contact type'
    end

    mail subject: @subject,
         template_name: @template,
         bcc: 'oscarj@experiment.com'
  end

  private

    def first_contact_journal
      ensure_contact_has_info :journal, :paper

      @template = 'phone_call'
      @subject = "I saw your paper in #{@contact.info[:journal]}"

      @published_at = @contact.info[:paper][:published_at].to_date

      @keyword = case @contact.info[:journal]
        when 'BMC Neuroscience', 'BMC Psychology', 'Behavioral and Brain Functions', 'BMC Neurology'
          'neuroscience & psychology'
        when 'BMC Cancer'
          'cancer'
        when 'BMC Evolutionary Biology', 'BMC Plant Biology', 'PLOS Biology', 'PLOS Computational Biology', 'BMC Systems Biology'
          'biology'
        when 'BMC Pediatrics'
          'pediatric'
        when 'BMC Genomics'
          'genetics'
        when 'Journal of Nanobiotechnology'
          'nanobiology'
        when 'PLOS Neglected Tropical Diseases'
          'neglected disease'
        when 'BMC Immunology'
          'health related'
        else
          raise "No keyword for this journal (#{@contact.info[:journal]})"
      end
    end

    def first_contact_manual
      ensure_contact_has_info :source, :url, :type

      @template = 'phone_call_manual'
      @subject = "I saw your story in #{@contact.info[:source]}"
    end

    def first_contact_institution_manual
      ensure_contact_has_info :link

      @template = 'institution_manual'
      @subject = 'Your research featured by Columbia University'
    end

    def ensure_contact_has_info(*keys)
      keys.each do |key|
        unless @contact.info.has_key? key
          raise "Contact info must have a #{key}"
        end
      end
    end
end
