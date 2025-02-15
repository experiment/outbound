source 'https://rubygems.org'
ruby '2.1.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.1'
# Use postgresql as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

gem 'puma'
gem 'rack-timeout'

gem 'sidekiq'
gem 'sinatra'

gem 'pry-rails'

# For importing contacts from google docs
gem 'google_drive', require: false

gem 'slim'

gem 'active_model_serializers'

# Use warden for github auth
gem 'warden'
gem 'warden-github'

gem 'mandrill-rails'

# For reading oscarj emails to backfill replies (see one_time:backfill_replies)
gem 'gmail', require: false
gem 'mime', '0.3.0', require: false

gem 'workflow'

group :production do
  gem 'rails_12factor'

  # Bugsnag for error tracking
  # https://bugsnag.com/experiment/outbound-dot-experiment-dot-com/errors
  gem 'bugsnag'

  gem 'newrelic_rpm'
end

group :development do
  gem 'dotenv-rails'
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :development, :test do
  # Use 3.0.0.beta2 for rails 4.1 support
  gem 'rspec', '~> 3.0.0.beta2'
  gem 'rspec-rails', '~> 3.0.0.beta2'

  gem 'factory_girl_rails'

  gem 'guard'
  gem 'guard-rspec'
end

group :test do
  gem 'mocha'
end

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
