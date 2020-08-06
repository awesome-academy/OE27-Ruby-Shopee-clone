Rails.application.routes.draw do
  devise_for :users, skip: [:session, :password, :registration], controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  mount Ckeditor::Engine => '/ckeditor'
  scope "(:locale)", locale: /en|vi/ do
    scope module: "users" do
      root "home#index"
      devise_for :users, skip: [:omniauth_callbacks]
      resources :products
      resources :categories do
        resources :products
      end
      resources :reviews
      resources :order_items
      resources :product_colors
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
