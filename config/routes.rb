LendSocial::Application.routes.draw do

    root :to => 'user_sessions#new'
    
    match 'login' => 'user_sessions#new', :as => :login
    match 'logout' => 'user_sessions#destroy', :as => :logout

    resources :users do
      resources :messages do
        resources :mesages
      end
    end

    resources :messages do
      resources :messages
    end

    resources :user_sessions
    
    resources :dashboard, :only => [:index] do
      collection do
        get 'update_status(/:page)', :action => :update_status, :as => :update_status
        get 'archived_statuses(/:page)', :action => :archived_statuses, :as => :archived_statuses
      end
    end
    
    resources :loans do
      collection do
        get :apply, :publish, :unpublish
      end
    end

    resources :businesses do
      resources :messages
      member do
        get :follow, :unfollow, :latest_followers
        get 'comments(/:page)', :action => :comments, :as => :comments
        get 'followers(/:page)', :action => :followers, :as => :followers
      end
    end

end
