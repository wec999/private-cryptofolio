Rails.application.routes.draw do
  resources :coins
  devise_for :users
  root to: 'pages#home'
  get '/pages', to: 'pages#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
