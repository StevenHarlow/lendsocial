LendSocial::Application.routes.draw do

    root :to => 'user_sessions#new'
    
    match 'login' => 'user_sessions#new', :as => :login
    match 'logout' => 'user_sessions#destroy', :as => :logout

    resources :users do
      resources :messages
    end

    resources :user_sessions
    
    resources :dashboard, :only => [:index] do
      collection do
        get 'update_status(/:page)', :action => :update_status
        get 'archived_statuses(/:page)', :action => :archived_statuses
      end
    end
    
    resources :loans do
      collection do
        get :apply, :publish, :unpublish
      end
    end

    resources :businesses

end
