Rails.application.routes.draw do
  get 'sessions/new'
  root 'users#new'
  resources :users
  # resources :likes, only: [:create, :destroy]
  post 'shops/create/:id', to: 'shops#create'
  delete 'shops/destroy/:id', to: 'shops#destroy'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :shops do
    collection do
      get "position"
      get "search"
      get "positionjs"
      get "thumbs_good"
    end
  end
end
