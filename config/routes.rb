Rails.application.routes.draw do
  get 'sessions/new'
  root "shops#index"
<<<<<<< HEAD
=======
  resources :users
  resources :likes
>>>>>>> 0ae8c69b0b4463c167568b981519d84011af1f83
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :shops do
    collection do
      get "position"
      get "search"
    end
  end
  resources :users

  resources :shops, only: [:index, :show, :edit, :create, :destroy, :update] do
    resources :likes, only: [:create, :destroy]
  end
  resources :users, only: [:index, :show, :edit, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
