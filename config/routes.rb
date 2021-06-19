Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/mail" if Rails.env.development?
  root  'tops#index'

  devise_for :users
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  
  resources :tops, only: [:index, :create] do
    collection do
      get 'tutorial'
      get 'contact'
    end
  end

end
