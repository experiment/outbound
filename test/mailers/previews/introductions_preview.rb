class IntroductionsPreview < ActionMailer::Preview
  def first_contact
    Introductions.first_contact(Contact.manual.last.id)
  end
end
