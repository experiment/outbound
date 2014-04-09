ActionMailer::Base.add_delivery_method :mandrill,
  Mail::SMTP,
  address: 'smtp.mandrillapp.com',
  port: 587,
  domain: 'heroku.com',
  user_name: ENV['MANDRILL_USERNAME'],
  password: ENV['MANDRILL_APIKEY'],
  authentication: 'plain'

if Rails.env.production?
  ActionMailer::Base.delivery_method = :mandrill
end
