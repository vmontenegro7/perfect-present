Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # resources :presents do
  #   collection do
  #     get :wishlist
  #   end
  # end

  resources :presents

  # resources :pages
  # resources :wishlist

  # resources :users do
  #   resources :presents
  # end
end
