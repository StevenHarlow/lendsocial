LendSocial::Application.routes.draw do
  devise_for :users, controllers: {registrations: 'registrations'}
  
  as :user do
    post '/login' => 'devise/sessions#create', as: :user_signin
    get '/logout' => 'devise/sessions#destroy', as: :user_signout
  end
  
  authenticated :user do
    root :to => 'dashboard#index'
  end
  
  root to: 'welcome#index'

  resources :pages, :only => :show
  
  resources :users, :except => :destroy do
    resources :messages
    member do
      get :follow, :unfollow, :latest_followers
      get '/comments(/:page)', action: :comments, as: :comments
      get '/business_followings(/:page)', action: :business_followings, as: :business_followings
      get '/followings(/:page)', action: :followings, as: :followings
      get '/followers(/:page)', action: :followers, as: :followers
    end
  end

  resources :messages do
    resources :messages
  end
  
  resources :dashboard, only: [:index] do
    collection do
      get '/update_status(/:page)', action: :update_status, as: :update_status
      get '/archived_statuses(/:page)', action: :archived_statuses, as: :archived_statuses
      get '/notifications(/:page)', action: :notifications, as: :notifications
      get '/notifications_counter', action: :notifications_counter
      get '/notifications_update', action: :notifications_update
    end
  end
  
  resources :loans, :except => :destroy do
    collection do
      get '/page-:page', action: :index
      get :apply, :publish, :unpublish
    end
  end

  resources :businesses, :except => :destroy do
    resources :messages
    member do
      get :follow, :unfollow, :latest_followers
      get '/comments(/:page)', action: :comments, as: :comments
      get '/followers(/:page)', action: :followers, as: :followers
      get '/connections(/:page)', action: :connections, as: :connections
      post '/connect/:business', action: :connect, as: :request
      get '/accept/:business', action: :accept_response, as: :accept
      get '/ignore/:business', action: :ignore_response, as: :ignore
      get '/cancel/:business', action: :cancel_request, as: :cancel 
    end
    collection do
      get '/user', action: :user, as: :user
    end
  end
end
