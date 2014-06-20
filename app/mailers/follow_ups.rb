class FollowUps < Mailer

  def interested_first_follow_up(contact_id)
    @contact = Contact.find contact_id

    mail subject: "Re: #{original_subject @contact}"
  end

  def mass_follow_up(contact_id)
    @contact = Contact.find contact_id

    @keyword = if @contact.info.has_key? :source
      @contact.info[:type]
    else
      case @contact.info[:journal]
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

    subject = if rand(2) == 1
      "Re: #{original_subject @contact}"
    else
      'Early-stage research funding - revisiting experiment.com'
    end

    mail subject: subject
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
