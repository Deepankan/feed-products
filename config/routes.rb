Rails.application.routes.draw do
  match '/upload_file', to: 'products#upload_file', as: 'upload_file', via: [:get, :post]

  resources :providers
  resources :products

  devise_for :users

  root 'products#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
