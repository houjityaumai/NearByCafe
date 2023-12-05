Rails.application.routes.draw do
  root "shops#index"
  resources :users
  resources :likes
  resources :shops do
    collection do
      get "position"
      get "search"
    end
  end

  resources :shops, only: [:index, :show, :edit, :create, :destroy, :update] do
    resources :likes, only: [:create, :destroy]
  end
  resources :users, only: [:index, :show, :edit, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
