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

  #一般ユーザ用
  resources :groups, only: [:index, :new, :create, :show] do
    member do
      get :old_events
    end
  end
  resources :members, only: [:create, :destroy]
  resources :events, only: [:index, :show]
  resources :participants, only: [:create, :destroy]

  #オーガナイザー用
  resource :organizing, only: [:show] do
    scope module: :organizing do

      resources :groups, only: [:show, :edit, :update, :destroy] do
        member do
          patch :give_owner
          post :create_organizer
          delete :delete_organizer
        end
        resources :events, only: [:new, :create, :edit, :update, :destroy] do
          member do
            delete :purge_image
          end
          collection do
            delete :delete_language
          end
        end
      end

      resources :members, only: [:update, :destroy] do
        collection do
          patch :accept_all_members
        end
        member do
          delete :deny
        end
      end

      resources :participants, only: [:update] do
        collection do
          patch :accept_all_participants
        end
        member do
          delete :deny
        end
      end
    end
  end

end
