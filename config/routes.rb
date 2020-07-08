Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "pages#home"
  get "pages/home", to: "pages#home"

  resources :recipes do
    resources :comments, only: [:create] #only route expose for comments is create
  end

  get '/signup', to: 'chefs#new'
  resources :chefs, except: [:new]

  #login routes, send to sessions controller
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  #all ingredient routes except destroy
  resources :ingredients, except: [:destroy]

  #set up realtime channels for comments
  mount ActionCable.server => "/cable"
  
end
