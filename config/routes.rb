Rails.application.routes.draw do
  root to: "pages#devtop"
  get "profile/:id", to: "pages#profile"
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  devise_scope :user do
    get "signup", to: "users/registrations#new"  #URIを短縮
    get "login", to: "users/sessions#new"
    delete "logout", to: "users/sessions#destroy"
  end
end
