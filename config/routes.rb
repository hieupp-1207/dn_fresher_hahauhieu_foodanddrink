Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    get "/home", to: "static_pages#home"
    devise_for :users
    as :user do
      get "/login", to: "devise/sessions#new"
      post "/login", to: "devise/sessions#create"
      delete "/logout", to: "devise/sessions#destroy"
      get "/signup", to: "devise/registrations#new"
      post "/signup", to: "devise/registrations#create"
    end
    
    resources :users, only: :show
    resources :products, only: %i(index show)
    resources :carts, only: %i(create index destroy) do
      collection do
        get "reset"
      end
    end
    namespace :admin do
      root "static_pages#home"
      resources :products, only: :index
      resources :orders, only: [:index, :update] do
        resources :order_details, only: :index
      end
    end
    resources :orders, only: %i(new create)
  end
end
