Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/mail" if Rails.env.development?
  root  'tops#index'

  devise_for :users
  
  resources :tops, only: [:index, :create] do
    collection do
      get 'tutorial'
      get 'contact'
    end
  end

end
