class Testing < ActionMailer::Base
  default to: 'ryan@experiment.com',
          from: 'oscarj@experiment.com'

  def test
    mail subject: 'outbound test',
         body: 'hello world'
  end
end
