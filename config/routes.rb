Rails.application.routes.draw do
  root 'pages#top'
  get "profile/:id", to: "pages#profile"
  # get "devtop", to: "pages#devtop"

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  devise_scope :user do
    get "signup", to: "users/registrations#new"
    get "login", to: "users/sessions#new"
    delete "logout", to: "users/sessions#destroy"
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  #一般ユーザ用
  resources :groups, only: [:new, :create, :show] do
    member do
      get :old_events
    end
  end
  resources :members, only: [:create, :destroy]
  resources :events, only: [:index, :show]
  resources :participants, only: [:create, :destroy] do
    collection do
      post :connection
    end
  end


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
            get :translation
            post :create_translation
            get :edit_translation
            patch :update_translation
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
