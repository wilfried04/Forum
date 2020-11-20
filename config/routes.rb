Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'forums#index', as: :root

  resources :forums,:except=>[:show] do
    resources :topics do 
      resources :comments,:only=>[:create,:destroy]
    end
  end 
end
