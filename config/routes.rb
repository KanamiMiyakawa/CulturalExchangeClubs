Rails.application.routes.draw do
  root to: "pages#devtop"
  get "profile/:id", to: "pages#profile"

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  devise_scope :user do
    get "signup", to: "users/registrations#new"
    get "login", to: "users/sessions#new"
    delete "logout", to: "users/sessions#destroy"
  end

  resources :groups

  resource :organizings, only: [:show] do
    scope module: :organizings do
      resources :members, only: [:update, :destroy]
      resources :groups, only: [:show] do
        member do
          patch :addorg
          delete :delorg
          patch :giveowner
        end
      end
    end
  end

  resources :members, only: [:create, :destroy]
end
