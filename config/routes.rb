Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'images#index'
  resources :categories
  resources :images
  get 'users/:username', to: "users#show", as: "user"
  # post 'upload', to: "users#upload"
  # get '/users/:username/download', to: "users#download", as: "user_download"
end
