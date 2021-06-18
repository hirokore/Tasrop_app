Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/mail" if Rails.env.development?
  root  'tops#index'

  resources :tops, only: [:index] do
    collection do
      get 'tutorial'
      get 'contact'
    end
  end

end
