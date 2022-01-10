Rails.application.routes.draw do
    scope "(:locale)", locale: /en|vi/ do
        root "static_pages#home"
        get "/", to: "static_pages#home"
        get "/home", to: "static_pages#home"
    end
end
