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

# Interceptors
%i(tag_email_interceptor mandrill_headers_interceptor).each do |interceptor|
  # Register both previewing and delivering
  ActionMailer::Base.register_preview_interceptor interceptor
  ActionMailer::Base.register_interceptor interceptor
end

# Observers
%i(record_send_observer).each do |observer|
  ActionMailer::Base.register_observer observer
end
