Rails.application.routes.draw do
  require "sidekiq/web"

  mount Ckeditor::Engine => "/ckeditor"
  mount Sidekiq::Web, at: "/sidekiq"
  scope "(:locale)", locale: /en|vi/ do
    scope module: "users" do
      root "home#index"
      devise_for :users, controllers: {
        sessions: "users/sessions",
        registrations: "users/registrations",
        passwords: "users/passwords"
      }
      resources :users, except: %i(new create)
      resources :products
      resources :categories do
        resources :products
      end
      resource :cart, only: [:show]
      resources :order_items, only: [:create, :update, :destroy]
      resources :product_colors
      resources :carts
      resources :orders
    end

    namespace :shops do
      root to: "homes#index"
      resources :products, param: :slug do
        member do
          put "restore", to: "products#restore"
        end
      end
      resources :orders, only: %i(index show update)
      get "export/products", to: "export_products#export_products", as: "export"
      post "import/products", to: "import_products#import_products", as: "import"
      get "export_status", to: "export_products#export_status"
      get "export_download", to: "export_products#export_download"
    end
  end
end
