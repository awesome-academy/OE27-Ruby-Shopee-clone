Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "home#index"

    namespace :shops do
      root to: "homes#index"
    end
  end
end
