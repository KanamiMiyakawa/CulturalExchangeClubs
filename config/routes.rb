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

  resources :groups, only: [:index, :new, :create, :show]

  resource :organizings, only: [:show, :create, :destroy] do
    scope module: :organizings do
      resources :members, only: [:update, :destroy] do
        collection do
          patch :accept_all_members
        end
        member do
          delete :deny
        end
      end
      resources :groups, only: [:show, :edit, :update, :destroy] do
        member do
          patch :give_owner
        end
      end
    end
  end

  resources :members, only: [:create, :destroy]
end
