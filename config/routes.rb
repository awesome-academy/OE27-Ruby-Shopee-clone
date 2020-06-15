Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "home#index"
  end
end
