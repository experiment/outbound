class Introductions < ActionMailer::Base
  default from: 'oscarj@experiment.com'

  def first_contact
    mail to: 'rpjlower@gmail.com',
         subject: 'WELCOME'
  end
end
