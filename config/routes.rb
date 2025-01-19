Rails.application.routes.draw do
  get 'home/index'
  get '/auth/:provider/callback', to: 'users/omniauth_callbacks#telegram'
  
  devise_for :users, controllers: { 
    omniauth_callbacks: 'users/omniauth_callbacks' 
  }
  resources :events
  resources :venues 
  resources :users do
    member do
      get :my_events
    end
    resource :profile do
    end
  end
  resources :users, only: [] do
    resource :profile, only: %i[new create edit update destroy show] do
      patch :update_cover_color, on: :member

      get :connect_telegram, on: :collection
    end
  end

  root 'home#index'
end
