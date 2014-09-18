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
    get :csv, to: 'contacts#csv'
  end

  namespace :gadget do
    resources :contacts, only: :create
    get 'contacts', constraints: { email: /.+/ }, to: 'contacts#show'
  end

  resources :contacts, only: :show

  resource :mandrill_hooks, only: %i(show create)

  get ':date' => 'application#batch', as: :batch
  root 'application#home'

end
