Rails.application.routes.draw do
  get 'sessions/new'
  root 'users#new'
  resources :users
  resources :likes
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
