Rails.application.routes.draw do
  get 'home/index'
  get '/auth/:provider/callback', to: 'users/omniauth_callbacks#telegram'
  
  devise_for :users, controllers: {
    registrations: 'devise/registrations'
  }
  
  devise_scope :user do
    get 'users/sign_up/landlord', to: 'devise/registrations#new_landlord', as: :landlord_sign_up
    post 'users/sign_up/landlord', to: 'devise/registrations#new_landlord', as: :create_landlord_sign_up
  end

  resources :events do
    resources :tickets, only: [:new, :create, :edit, :update, :destroy]
    resources :reviews, only: [:create, :destroy]
  end
  
  resources :venues do
    resources :reviews, only: %i[create destroy]
  end
  
  resources :users do
    member do
      get :my_events
      get :events
      get :participations
    end
    resource :profile do
      member do
      get :reviews 
    end

      resources :reviews, only: [:create, :destroy]
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
