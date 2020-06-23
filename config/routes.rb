Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "pages#home"
  get "pages/home", to: "pages#home"

  resources :recipes

  get '/signup', to: 'chefs#new'
  resources :chefs, except: [:new]

  #login routes, send to sessions controller
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/login', to: 'sessions#destroy'
end
