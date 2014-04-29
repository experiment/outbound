class IntroductionsPreview < ActionMailer::Preview
  def first_contact
    Introductions.first_contact(Contact.last.id)
  end
end
