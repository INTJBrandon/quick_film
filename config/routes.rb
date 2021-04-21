Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'movies#index'
  get '/movies/top-rated', to: 'movies#topRated' 
  get '/auth/google_oauth2/callback', to: 'sessions#google_login'
  resources :movies, only: [:index, :show]
  resources :tickets, only: [:index, :show, :new, :create]

  resources :movies, only: [:show] do 
    resources :tickets, only: [:new, :show]
  end

  resources :users, only: [:show] do
    resources :tickets, only: [:index]
  end

  get '/profile', to: 'users#index', as: 'profile'
  get '/signup', to: 'users#new', as: 'signup'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  
end
