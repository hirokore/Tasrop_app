Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/mail" if Rails.env.development?
  root  'tops#index'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    omniauth_callbacks: "users/omniauth_callbacks"
  }  
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  resources :users, only: [:show, :index] do
    collection do
      get 'follow/:id', to: 'users#follow', as: 'follow'
      get 'followed/:id', to: 'users#followed', as: 'followed'
    end
  end
  resources :relationships, only: [:create, :destroy]
  resources :tops, only: [:index, :create] do
    collection do
      get 'tutorial'
      get 'contact'
    end
  end

end
