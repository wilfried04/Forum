Rails.application.routes.draw do
  devise_for :users
  root "topics#index"
  resources :topics do
    collection do
      get 'search'
    end
    resources :comments, only: :create
  end
  resources :categories, only: :show
end
