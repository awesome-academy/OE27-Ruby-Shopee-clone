Rails.application.routes.draw do
  get 'users/product_colors'
  mount Ckeditor::Engine => '/ckeditor'
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
      resource :cart, only: [:show]
      resources :order_items, only: [:create, :update, :destroy]
      resources :product_colors
      resources :carts
      resources :orders
    end

    namespace :shops do
      root to: "homes#index"
      resources :products, param: :slug
      resources :orders, only: %i(index show update)
      get "export/products", to: "files#export_file", as: "export"
      post "import/products", to: "files#import_file", as: "import"
    end
  end
end
