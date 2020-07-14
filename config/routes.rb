Rails.application.routes.draw do
  require "sidekiq/web"

  mount Ckeditor::Engine => "/ckeditor"
  mount Sidekiq::Web, at: "/sidekiq"
  scope "(:locale)", locale: /en|vi/ do
    scope module: "users" do
      root "home#index"
      get "/login", to: "sessions#new"
      post "/login", to: "sessions#create"
      delete "/logout", to: "sessions#destroy"
      resources :users
      resources :products
      resources :categories do
        resources :products
      end
    end

    namespace :shops do
      root to: "homes#index"
      resources :products, param: :slug
      resources :orders, only: %i(index show update)
      get "export/products", to: "export_products#export_products", as: "export"
      post "import/products", to: "import_products#import_products", as: "import"
      get "export_status", to: "export_products#export_status"
      get "export_download", to: "export_products#export_download"
    end
  end
end
