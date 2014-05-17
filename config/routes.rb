Rails.application.routes.draw do

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  namespace :api do
    resources :contacts, only: :create do
      get :show, on: :collection, constraints: { email: /.+/ }
      # GET so we can use JSONP
      get 'process/event', to: 'contacts/processes#event'
    end
    resource :events, only: :create
  end

  resource :mandrill_hooks, only: %i(show create)

  root 'application#home'

end
