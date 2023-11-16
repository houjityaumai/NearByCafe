Rails.application.routes.draw do
  root "shops#index"
  resources :users
  resources :shops do
    collection do
      get "position"
      get "search"
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
