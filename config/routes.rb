Rails.application.routes.draw do
  resources :users, only: [:show]
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  devise_scope :user do
    get "signup", :to => "users/registrations#new"  #URIを短縮
    get "login", :to => "users/sessions#new"
    get "logout", :to => "users/sessions#destroy"
  end
end
