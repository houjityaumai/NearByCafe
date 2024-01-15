Rails.application.routes.draw do
  get 'sessions/new'
  root "shops#index"
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
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
