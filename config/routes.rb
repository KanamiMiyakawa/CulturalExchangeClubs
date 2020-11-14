Rails.application.routes.draw do
  root to: "pages#devtop"
  resources :users, only: [:show]
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
