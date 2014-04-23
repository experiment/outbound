class Testing < ActionMailer::Base
  def test
    mail to: 'ryan@experiment.com',
         subject: 'outbound test',
         body: 'hello world'
  end
end
