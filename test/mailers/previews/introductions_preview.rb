class IntroductionsPreview < ActionMailer::Preview
  def first_contact
    Introductions.first_contact(Contact.institution_manual.last.id)
  end
end
