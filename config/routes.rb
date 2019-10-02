require 'sidekiq/web'
Rails.application.routes.draw do
  post '/rate' => 'rater#create', :as => 'rate'
  root to: 'home#index'
  get '/search' => 'home#search', :as => 'search'
  post 'lang/:locale' => 'home#change_locale', as: :change_locale

  resources :admin_permit_organizations

  resources :cars do
    resources :operations
    collection do
      get 'models'
      get 'years'
    end
  end

  resources :profiles, only: [:show, :edit, :update]
  
  resources :organizations do
    resources :organization_addresses
    collection do
      get 'checkboxes'
      get 'choosen_organizations'
    end
    member do
      get :change_state
    end
  end

  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks',
  registrations: 'users/registrations' }
  get '/auth/:action/callback', controller: 'authentication',
  constraints: { action: /twitter|facebook|linkedin/ }
end
