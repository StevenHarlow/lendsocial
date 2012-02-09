LendSocial::Application.routes.draw do

    root :to => 'user_sessions#new'

    resources :profiles do
      collection do
        get :follow, :to => 'followings#create'
        get :unfollow, :to => 'followings#destroy'
      end
    end
    
    resources :users do
      resources :messages
    end

    resources :user_sessions, :followings
    
    resources :dashboard, :only => [:index] do
      collection do
        get 'update_status(/:page)', :action => :update_status
        get 'archived_statuses(/:page)', :action => :archived_statuses
      end
    end
    
    match 'login' => 'user_sessions#new', :as => :login
    match 'logout' => 'user_sessions#destroy', :as => :logout
    
    resources :loans do
      collection do
        get :apply, :publish, :unpublish
      end
    end

    resources :businesses

end
