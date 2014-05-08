Rails.application.routes.draw do

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  namespace :api do
    resources :contacts, only: %i(show create)
    resource :events, only: :create
  end

  resource :mandrill_hooks, only: %i(show create)

  root 'application#home'

end
