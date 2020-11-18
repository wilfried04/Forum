Rails.application.routes.draw do
  get 'sessions/new'
  root 'topics#index'
  resources :topics do
    collection do
      post :confirm
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  mount LetterOpenerWeb::Engine, at: "/inbox" if Rails.env.development?
end
