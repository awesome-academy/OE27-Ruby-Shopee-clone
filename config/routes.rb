Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "home#index"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    resources :users

    namespace :shops do
      root to: "homes#index"
    end
  end
end
