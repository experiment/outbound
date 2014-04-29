Rails.application.routes.draw do

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  namespace :api do
    resource :contacts, only: :create
  end

  resource :mandrill_hooks, only: %i(show create)

  root 'application#home'

end
